import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:built_collection/built_collection.dart';
import 'package:receipt_wrangler_mobile/interfaces/form_item.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/category_model.dart';
import 'package:receipt_wrangler_mobile/models/custom_field_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/models/system_settings_model.dart';
import 'package:receipt_wrangler_mobile/models/tag_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_form.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';

import '../utils/test_router.dart';

api.Receipt buildReceipt({
  required int id,
  required String name,
  required String amount,
  required DateTime date,
  required int groupId,
  int paidByUserId = 0,
  api.ReceiptStatus status = api.ReceiptStatus.OPEN,
}) {
  return (api.ReceiptBuilder()
        ..id = id
        ..name = name
        ..amount = amount
        ..date = date.toIso8601String()
        ..groupId = groupId
        ..paidByUserId = paidByUserId
        ..status = status)
      .build();
}

api.Group buildGroup({
  required int id,
  required String name,
  required bool isAllGroup,
  bool hideReceiptCategories = false,
  bool hideReceiptTags = false,
  bool hideItemCategories = false,
  bool hideItemTags = false,
  List<api.GroupMember>? members,
}) {
  return (api.GroupBuilder()
        ..id = id
        ..name = name
        ..isAllGroup = isAllGroup
        ..status = api.GroupStatus.ACTIVE
        ..groupMembers = (members != null)
            ? ListBuilder<api.GroupMember>(members)
            : ListBuilder<api.GroupMember>([])
        ..groupReceiptSettings = (api.GroupReceiptSettingsBuilder()
          ..id = id
          ..groupId = id
          ..createdAt = '2024-01-01T00:00:00Z'
          ..createdBy = 0
          ..updatedAt = '2024-01-01T00:00:00Z'
          ..hideReceiptCategories = hideReceiptCategories
          ..hideReceiptTags = hideReceiptTags
          ..hideItemCategories = hideItemCategories
          ..hideItemTags = hideItemTags))
      .build();
}

api.GroupMember buildMember({required int groupId, required int userId}) {
  return (api.GroupMemberBuilder()
        ..groupId = groupId
        ..userId = userId
        ..groupRole = api.GroupRole.EDITOR)
      .build();
}

api.UserView buildUser({required int id, required String name}) {
  return (api.UserViewBuilder()
        ..id = id
        ..username = 'u$id'
        ..displayName = name
        ..isDummyUser = false
        ..userRole = api.UserRole.USER)
      .build();
}

Widget buildReceiptFormApp({
  required String routePath,
  required ReceiptModel receiptModel,
  required GroupModel groupModel,
  required CategoryModel categoryModel,
  required TagModel tagModel,
  required UserModel userModel,
  CustomFieldModel? customFieldModel,
  SystemSettingsModel? systemSettingsModel,
}) {
  final formKey = GlobalKey<FormBuilderState>();
  final router = buildTestRouter(
    initialLocation: routePath,
    builder: (_) => MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: receiptModel),
        ChangeNotifierProvider.value(value: groupModel),
        ChangeNotifierProvider.value(value: categoryModel),
        ChangeNotifierProvider.value(value: tagModel),
        ChangeNotifierProvider.value(value: userModel),
        ChangeNotifierProvider.value(
            value: customFieldModel ?? CustomFieldModel()),
        ChangeNotifierProvider.value(
            value: systemSettingsModel ?? SystemSettingsModel()),
      ],
      child: FormBuilder(
        key: formKey,
        child: Material(
          child: SingleChildScrollView(
            child: ReceiptForm(formKey: formKey),
          ),
        ),
      ),
    ),
  );

  return MaterialApp.router(routerConfig: router);
}

void main() {
  group('ReceiptForm - Add mode', () {
    testWidgets('shows editable fields and pickers when adding', (tester) async {
      final receiptModel = ReceiptModel();
      final groupModel = GroupModel();
      final categoryModel = CategoryModel();
      final tagModel = TagModel();
      final userModel = UserModel();

      final user = buildUser(id: 10, name: 'Alice');
      userModel.setUsers([user]);

      final group = buildGroup(
        id: 1,
        name: 'Test Group',
        isAllGroup: false,
        hideReceiptCategories: false,
        hideReceiptTags: false,
        hideItemCategories: false,
        hideItemTags: false,
        members: [buildMember(groupId: 1, userId: user.id)],
      );
      groupModel.setGroups([group]);

      // seed categories and tags
      categoryModel.setCategories([
        (api.CategoryBuilder()
              ..id = 1
              ..name = 'Food')
            .build(),
        (api.CategoryBuilder()
              ..id = 2
              ..name = 'Transport')
            .build(),
      ]);
      tagModel.setTags([
        (api.TagBuilder()
              ..id = 1
              ..name = 'Important')
            .build(),
      ]);

      // Set receipt in add context
      final receipt = buildReceipt(
        id: 1,
        name: 'Groceries',
        amount: '12.34',
        date: DateTime(2024, 7, 15),
        groupId: 1,
      );
      receiptModel.setReceipt(receipt, false);

      final app = buildReceiptFormApp(
        routePath: '/receipts/add',
        receiptModel: receiptModel,
        groupModel: groupModel,
        categoryModel: categoryModel,
        tagModel: tagModel,
        userModel: userModel,
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Date should be a picker in add/edit
      expect(find.byType(FormBuilderDateTimePicker), findsOneWidget);

      // Group and Paid By dropdown labels should be present
      expect(find.text('Group'), findsWidgets);
      expect(find.text('Paid By'), findsWidgets);

      // Categories and Tags fields visible because group settings allow
      expect(find.text('Categories'), findsWidgets);
      expect(find.text('Tags'), findsWidgets);

      // Items/Shares add actions visible (not in view mode and groupId > 0)
      expect(find.byTooltip('Add Item'), findsOneWidget);
      expect(find.byTooltip('Quick Actions'), findsOneWidget);
    });
  });

  group('ReceiptForm - View mode', () {
    testWidgets('shows read-only date text and hides add actions', (tester) async {
      final receiptModel = ReceiptModel();
      final groupModel = GroupModel();
      final categoryModel = CategoryModel();
      final tagModel = TagModel();
      final userModel = UserModel();

      final group = buildGroup(
        id: 1,
        name: 'Test Group',
        isAllGroup: false,
      );
      groupModel.setGroups([group]);

      final date = DateTime(2024, 1, 2);
      final receipt = buildReceipt(
        id: 1,
        name: 'Groceries',
        amount: '12.34',
        date: date,
        groupId: 1,
      );
      receiptModel.setReceipt(receipt, false);

      final app = buildReceiptFormApp(
        routePath: '/receipts/1/view',
        receiptModel: receiptModel,
        groupModel: groupModel,
        categoryModel: categoryModel,
        tagModel: tagModel,
        userModel: userModel,
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Date picker should NOT be present in view mode
      expect(find.byType(FormBuilderDateTimePicker), findsNothing);

      // Formatted date should be shown as read-only text
      final formatted = formatDate(defaultDateFormat, date);
      expect(find.text(formatted), findsWidgets);

      // Add actions should be hidden in view mode
      expect(find.byTooltip('Add Item'), findsNothing);
      expect(find.byTooltip('Quick Actions'), findsNothing);
    });
  });

  group('ReceiptForm - Edit mode', () {
    testWidgets('sync with items updates amount and shows helper', (tester) async {
      final receiptModel = ReceiptModel();
      final groupModel = GroupModel();
      final categoryModel = CategoryModel();
      final tagModel = TagModel();
      final userModel = UserModel();

      final group = buildGroup(
        id: 1,
        name: 'Test Group',
        isAllGroup: false,
      );
      groupModel.setGroups([group]);

      final receipt = buildReceipt(
        id: 1,
        name: 'Groceries',
        amount: '0.00',
        date: DateTime(2024, 4, 10),
        groupId: 1,
      );
      receiptModel.setReceipt(receipt, false);

      // Seed items that should be summed
      final itemA = (api.ItemBuilder()
            ..name = 'Item A'
            ..amount = '10.00'
            ..chargedToUserId = null
            ..receiptId = receipt.id
            ..status = api.ItemStatus.OPEN)
          .build();
      final itemB = (api.ItemBuilder()
            ..name = 'Item B'
            ..amount = '5.50'
            ..chargedToUserId = null
            ..receiptId = receipt.id
            ..status = api.ItemStatus.OPEN)
          .build();
      receiptModel.setItems([
        FormItem.fromItem(itemA),
        FormItem.fromItem(itemB),
      ]);

      final app = buildReceiptFormApp(
        routePath: '/receipts/1/edit',
        receiptModel: receiptModel,
        groupModel: groupModel,
        categoryModel: categoryModel,
        tagModel: tagModel,
        userModel: userModel,
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Sync with items checkbox should be visible in edit mode
      expect(find.text('Sync with items'), findsOneWidget);

      // Toggle sync and expect amount to reflect items total and helper text visible
      await tester.tap(find.byType(CheckboxListTile));
      await tester.pumpAndSettle();

      // Helper text visible
      expect(find.text('Automatically calculate receipt amount from item totals'),
          findsOneWidget);

      // Model updated
      expect(receiptModel.modifiedReceipt.amount, '15.50');
    });

    testWidgets('shows group selection warning when groupId is 0', (tester) async {
      final receiptModel = ReceiptModel();
      final groupModel = GroupModel();
      final categoryModel = CategoryModel();
      final tagModel = TagModel();
      final userModel = UserModel();

      // Receipt with no group selected
      final receipt = buildReceipt(
        id: 1,
        name: 'Untitled',
        amount: '0.00',
        date: DateTime(2024, 4, 10),
        groupId: 0,
      );
      receiptModel.setReceipt(receipt, false);

      final app = buildReceiptFormApp(
        routePath: '/receipts/1/edit',
        receiptModel: receiptModel,
        groupModel: groupModel,
        categoryModel: categoryModel,
        tagModel: tagModel,
        userModel: userModel,
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      expect(find.text('Please select a group before adding items'),
          findsOneWidget);
      expect(find.text('Please select a group before adding shares'),
          findsOneWidget);
    });
  });
}
