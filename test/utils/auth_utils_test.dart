import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/models/category_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/system_settings_model.dart';
import 'package:receipt_wrangler_mobile/models/tag_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/models/user_preferences_model.dart';
import 'package:receipt_wrangler_mobile/utils/auth.dart';

class _FakeAuthModel extends AuthModel {
  String? _jwt;
  String? _refresh;

  @override
  Future<void> setJwt(String? jwt) async {
    _jwt = jwt;
  }

  @override
  Future<void> setRefreshToken(String? refreshToken) async {
    _refresh = refreshToken;
  }

  String? get capturedJwt => _jwt;
  String? get capturedRefresh => _refresh;
}

api.Group _group({required int id, required String name}) {
  return (api.GroupBuilder()
        ..id = id
        ..name = name
        ..isAllGroup = false
        ..status = api.GroupStatus.ACTIVE
        ..groupMembers = ListBuilder<api.GroupMember>([])
        ..groupReceiptSettings.replace((api.GroupReceiptSettingsBuilder()
              ..id = id
              ..groupId = id
              ..createdAt = '2024-01-01T00:00:00Z'
              ..hideReceiptCategories = false
              ..hideReceiptTags = false
              ..hideItemCategories = false
              ..hideItemTags = false)
            .build()))
      .build();
}

api.UserView _user({required int id, required String name}) {
  return (api.UserViewBuilder()
        ..id = id
        ..username = 'u$id'
        ..displayName = name
        ..isDummyUser = false
        ..userRole = api.UserRole.USER)
      .build();
}

api.Category _category(int id, String name) =>
    (api.CategoryBuilder()..id = id..name = name).build();
api.Tag _tag(int id, String name) =>
    (api.TagBuilder()..id = id..name = name).build();

api.UserPreferences _prefs(int userId) => (api.UserPreferencesBuilder()
      ..id = 1
      ..createdAt = '2024-01-01T00:00:00Z'
      ..userId = userId
      ..quickScanDefaultGroupId = 1
      ..quickScanDefaultPaidById = userId
      ..quickScanDefaultStatus = api.ReceiptStatus.OPEN)
    .build();

api.Claims _claims(int userId) => (api.ClaimsBuilder()
      ..userId = userId
      ..userRole = api.UserRole.USER
      ..displayName = 'User $userId'
      ..defaultAvatarColor = '#fff'
      ..username = 'u$userId'
      ..iss = 'test'
      ..exp = 9999999999)
    .build();

api.FeatureConfig _feature({required bool ai, required bool signUp}) =>
    (api.FeatureConfigBuilder()
          ..aiPoweredReceipts = ai
          ..enableLocalSignUp = signUp)
        .build();

api.About _about() => (api.AboutBuilder()
      ..buildDate = '2024-01-01'
      ..version = '1.0.0')
    .build();

api.AppData _appData({
  String? jwt,
  String? refresh,
  String currencyDisplay = 'X',
  api.CurrencySeparator? thousand = api.CurrencySeparator.comma,
  api.CurrencySeparator? decimal = api.CurrencySeparator.period,
  api.CurrencySymbolPosition? position = api.CurrencySymbolPosition.END,
  bool? hideDecimals = false,
}) {
  return (api.AppDataBuilder()
        ..about.replace(_about())
        ..claims.replace(_claims(1))
        ..groups = ListBuilder<api.Group>([_group(id: 1, name: 'G')])
        ..users = ListBuilder<api.UserView>([_user(id: 1, name: 'Alice')])
        ..userPreferences.replace(_prefs(1))
        ..featureConfig.replace(_feature(ai: true, signUp: true))
        ..categories = ListBuilder<api.Category>([
          _category(1, 'Food'),
        ])
        ..tags = ListBuilder<api.Tag>([
          _tag(1, 'Important'),
        ])
        ..jwt = jwt
        ..refreshToken = refresh
        ..currencyDisplay = currencyDisplay
        ..currencyThousandthsSeparator = thousand
        ..currencyDecimalSeparator = decimal
        ..currencySymbolPosition = position
        ..currencyHideDecimalPlaces = hideDecimals
        ..icons = ListBuilder<api.Icon>([]))
      .build();
}

void main() {
  group('isTokenValid', () {
    test('returns false for null/empty', () {
      expect(isTokenValid(null), isFalse);
      expect(isTokenValid(''), isFalse);
    });

    test('returns true for future exp and false for past exp', () {
      final nowSec = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final future = JWT({'exp': nowSec + 3600}).sign(SecretKey('secret'));
      final past = JWT({'exp': nowSec - 5}).sign(SecretKey('secret'));

      expect(isTokenValid(future), isTrue);
      expect(isTokenValid(past), isFalse);
    });
  });

  group('storeAppData', () {
    test('maps app data to models and tokens when provided', () async {
      final auth = _FakeAuthModel();
      final groups = GroupModel();
      final users = UserModel();
      final prefs = UserPreferencesModel();
      final categories = CategoryModel();
      final tags = TagModel();
      final system = SystemSettingsModel();

      final data = _appData(
        jwt: 'jwt-token',
        refresh: 'refresh-token',
        currencyDisplay: '€',
        decimal: api.CurrencySeparator.period,
        thousand: api.CurrencySeparator.comma,
        position: api.CurrencySymbolPosition.START,
        hideDecimals: true,
      );

      await storeAppData(auth, groups, users, prefs, categories, tags, system, data);

      // tokens captured
      expect(auth.capturedJwt, 'jwt-token');
      expect(auth.capturedRefresh, 'refresh-token');

      // claims + feature config mapped
      expect(auth.claims!.userId, 1);
      expect(auth.featureConfig.aiPoweredReceipts, isTrue);
      expect(auth.featureConfig.enableLocalSignUp, isTrue);

      // collections mapped
      expect(groups.groups.length, 1);
      expect(users.users.length, 1);
      expect(categories.categories.length, 1);
      expect(tags.tags.length, 1);

      // preferences mapped
      expect(prefs.userPreferences.userId, 1);

      // system settings mapped
      expect(system.getCurrencyDisplay, '€');
      expect(system.getCurrencyDecimalSeparator, api.CurrencySeparator.period);
      expect(system.getCurrencyThousandSeparator, api.CurrencySeparator.comma);
      expect(system.getCurrencySymbolPosition, api.CurrencySymbolPosition.START);
      expect(system.getCurrencyHideDecimalPlaces, isTrue);
    });

    test('applies defaults when optional currency fields are null', () async {
      final auth = _FakeAuthModel();
      final groups = GroupModel();
      final users = UserModel();
      final prefs = UserPreferencesModel();
      final categories = CategoryModel();
      final tags = TagModel();
      final system = SystemSettingsModel();

      final data = _appData(
        jwt: null,
        refresh: null,
        currencyDisplay: 'X',
        decimal: null,
        thousand: null,
        position: null,
        hideDecimals: null,
      );

      await storeAppData(auth, groups, users, prefs, categories, tags, system, data);

      expect(auth.capturedJwt, isNull);
      expect(auth.capturedRefresh, isNull);
      expect(system.getCurrencyDisplay, 'X');
      expect(system.getCurrencyDecimalSeparator, api.CurrencySeparator.period);
      expect(system.getCurrencyThousandSeparator, api.CurrencySeparator.comma);
      expect(system.getCurrencySymbolPosition, api.CurrencySymbolPosition.END);
      expect(system.getCurrencyHideDecimalPlaces, isFalse);
    });
  });
}
