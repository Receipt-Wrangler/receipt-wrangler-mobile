// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppData extends AppData {
  @override
  final Claims claims;
  @override
  final BuiltList<Group> groups;
  @override
  final BuiltList<UserView> users;
  @override
  final UserPreferences userPreferences;
  @override
  final FeatureConfig featureConfig;
  @override
  final BuiltList<Category> categories;
  @override
  final BuiltList<Tag> tags;
  @override
  final String? jwt;
  @override
  final String? refreshToken;
  @override
  final String currencyDisplay;

  factory _$AppData([void Function(AppDataBuilder)? updates]) =>
      (new AppDataBuilder()..update(updates))._build();

  _$AppData._(
      {required this.claims,
      required this.groups,
      required this.users,
      required this.userPreferences,
      required this.featureConfig,
      required this.categories,
      required this.tags,
      this.jwt,
      this.refreshToken,
      required this.currencyDisplay})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(claims, r'AppData', 'claims');
    BuiltValueNullFieldError.checkNotNull(groups, r'AppData', 'groups');
    BuiltValueNullFieldError.checkNotNull(users, r'AppData', 'users');
    BuiltValueNullFieldError.checkNotNull(
        userPreferences, r'AppData', 'userPreferences');
    BuiltValueNullFieldError.checkNotNull(
        featureConfig, r'AppData', 'featureConfig');
    BuiltValueNullFieldError.checkNotNull(categories, r'AppData', 'categories');
    BuiltValueNullFieldError.checkNotNull(tags, r'AppData', 'tags');
    BuiltValueNullFieldError.checkNotNull(
        currencyDisplay, r'AppData', 'currencyDisplay');
  }

  @override
  AppData rebuild(void Function(AppDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppDataBuilder toBuilder() => new AppDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppData &&
        claims == other.claims &&
        groups == other.groups &&
        users == other.users &&
        userPreferences == other.userPreferences &&
        featureConfig == other.featureConfig &&
        categories == other.categories &&
        tags == other.tags &&
        jwt == other.jwt &&
        refreshToken == other.refreshToken &&
        currencyDisplay == other.currencyDisplay;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, claims.hashCode);
    _$hash = $jc(_$hash, groups.hashCode);
    _$hash = $jc(_$hash, users.hashCode);
    _$hash = $jc(_$hash, userPreferences.hashCode);
    _$hash = $jc(_$hash, featureConfig.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, jwt.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, currencyDisplay.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppData')
          ..add('claims', claims)
          ..add('groups', groups)
          ..add('users', users)
          ..add('userPreferences', userPreferences)
          ..add('featureConfig', featureConfig)
          ..add('categories', categories)
          ..add('tags', tags)
          ..add('jwt', jwt)
          ..add('refreshToken', refreshToken)
          ..add('currencyDisplay', currencyDisplay))
        .toString();
  }
}

class AppDataBuilder implements Builder<AppData, AppDataBuilder> {
  _$AppData? _$v;

  ClaimsBuilder? _claims;
  ClaimsBuilder get claims => _$this._claims ??= new ClaimsBuilder();
  set claims(ClaimsBuilder? claims) => _$this._claims = claims;

  ListBuilder<Group>? _groups;
  ListBuilder<Group> get groups => _$this._groups ??= new ListBuilder<Group>();
  set groups(ListBuilder<Group>? groups) => _$this._groups = groups;

  ListBuilder<UserView>? _users;
  ListBuilder<UserView> get users =>
      _$this._users ??= new ListBuilder<UserView>();
  set users(ListBuilder<UserView>? users) => _$this._users = users;

  UserPreferencesBuilder? _userPreferences;
  UserPreferencesBuilder get userPreferences =>
      _$this._userPreferences ??= new UserPreferencesBuilder();
  set userPreferences(UserPreferencesBuilder? userPreferences) =>
      _$this._userPreferences = userPreferences;

  FeatureConfigBuilder? _featureConfig;
  FeatureConfigBuilder get featureConfig =>
      _$this._featureConfig ??= new FeatureConfigBuilder();
  set featureConfig(FeatureConfigBuilder? featureConfig) =>
      _$this._featureConfig = featureConfig;

  ListBuilder<Category>? _categories;
  ListBuilder<Category> get categories =>
      _$this._categories ??= new ListBuilder<Category>();
  set categories(ListBuilder<Category>? categories) =>
      _$this._categories = categories;

  ListBuilder<Tag>? _tags;
  ListBuilder<Tag> get tags => _$this._tags ??= new ListBuilder<Tag>();
  set tags(ListBuilder<Tag>? tags) => _$this._tags = tags;

  String? _jwt;
  String? get jwt => _$this._jwt;
  set jwt(String? jwt) => _$this._jwt = jwt;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  String? _currencyDisplay;
  String? get currencyDisplay => _$this._currencyDisplay;
  set currencyDisplay(String? currencyDisplay) =>
      _$this._currencyDisplay = currencyDisplay;

  AppDataBuilder() {
    AppData._defaults(this);
  }

  AppDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _claims = $v.claims.toBuilder();
      _groups = $v.groups.toBuilder();
      _users = $v.users.toBuilder();
      _userPreferences = $v.userPreferences.toBuilder();
      _featureConfig = $v.featureConfig.toBuilder();
      _categories = $v.categories.toBuilder();
      _tags = $v.tags.toBuilder();
      _jwt = $v.jwt;
      _refreshToken = $v.refreshToken;
      _currencyDisplay = $v.currencyDisplay;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppData;
  }

  @override
  void update(void Function(AppDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppData build() => _build();

  _$AppData _build() {
    _$AppData _$result;
    try {
      _$result = _$v ??
          new _$AppData._(
              claims: claims.build(),
              groups: groups.build(),
              users: users.build(),
              userPreferences: userPreferences.build(),
              featureConfig: featureConfig.build(),
              categories: categories.build(),
              tags: tags.build(),
              jwt: jwt,
              refreshToken: refreshToken,
              currencyDisplay: BuiltValueNullFieldError.checkNotNull(
                  currencyDisplay, r'AppData', 'currencyDisplay'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'claims';
        claims.build();
        _$failedField = 'groups';
        groups.build();
        _$failedField = 'users';
        users.build();
        _$failedField = 'userPreferences';
        userPreferences.build();
        _$failedField = 'featureConfig';
        featureConfig.build();
        _$failedField = 'categories';
        categories.build();
        _$failedField = 'tags';
        tags.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AppData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
