import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/amount_field.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/category_select_field.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/quick_add_shell.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/tag_select_field.dart';

import '../../interfaces/form_item.dart';
import '../../models/group_model.dart';
import '../../models/receipt_model.dart';

class QuickAddItemBar extends StatefulWidget {
  const QuickAddItemBar({
    super.key,
    required this.groupId,
    required this.formState,
    required this.isVisible,
    required this.onToggleVisibility,
  });

  final int groupId;
  final WranglerFormState formState;
  final bool isVisible;
  final VoidCallback onToggleVisibility;

  @override
  State<QuickAddItemBar> createState() => _QuickAddItemBarState();
}

class _QuickAddItemBarState extends State<QuickAddItemBar> {
  final _quickAddFormKey = GlobalKey<FormBuilderState>();
  late final groupModel = Provider.of<GroupModel>(context, listen: false);
  late final receiptModel = Provider.of<ReceiptModel>(context, listen: false);

  bool get _showCategories =>
      groupModel.getGroupReceiptSettings(widget.groupId)?.hideItemCategories == false;

  bool get _showTags =>
      groupModel.getGroupReceiptSettings(widget.groupId)?.hideItemTags == false;

  void _addItem() {
    if (!_quickAddFormKey.currentState!.saveAndValidate()) {
      return;
    }

    final form = _quickAddFormKey.currentState!.value;
    final items = [...receiptModel.items];
    final categories = form["categories"] ?? [];
    final tags = form["tags"] ?? [];

    final newItem = (api.ItemBuilder()
          ..name = form["name"] ?? ""
          ..amount = form["amount"] ?? "0.00"
          ..chargedToUserId = null
          ..receiptId = receiptModel.receipt?.id ?? 0
          ..status = api.ItemStatus.OPEN
          ..categories = ListBuilder<api.Category>(categories)
          ..tags = ListBuilder<api.Tag>(tags))
        .build();

    items.add(FormItem.fromItem(newItem));
    receiptModel.setItems(items);

    // Reset form
    _quickAddFormKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return QuickAddShell(
      title: "Quick Add Item",
      formKey: _quickAddFormKey,
      formState: widget.formState,
      isVisible: widget.isVisible,
      onToggleVisibility: widget.onToggleVisibility,
      onSubmit: _addItem,
      submitButtonText: "Add Item",
      submitButtonIcon: Icons.add,
      child: _buildFormContent(),
    );
  }

  Widget _buildFormContent() {
    return Column(
      children: [
        FormBuilderTextField(
          name: "name",
          decoration: const InputDecoration(
            labelText: "Item Name",
            hintText: "Enter item name",
            border: OutlineInputBorder(),
          ),
          validator: FormBuilderValidators.required(),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        AmountField(
          label: "Amount",
          fieldName: "amount",
          initialAmount: "0.00",
          formState: widget.formState,
        ),
        if (_showCategories) ...[
          const SizedBox(height: 16),
          CategorySelectField(
            label: "Categories",
            fieldName: "categories",
            initialCategories: [],
            formState: widget.formState,
            onCategoriesChanged: (categories) {
              _quickAddFormKey.currentState!.fields["categories"]!
                  .setValue(categories);
            },
          ),
        ],
        if (_showTags) ...[
          const SizedBox(height: 16),
          TagSelectField(
            label: "Tags",
            fieldName: "tags",
            initialTags: [],
            formState: widget.formState,
            onTagsChanged: (tags) {
              _quickAddFormKey.currentState!.fields["tags"]!
                  .setValue(tags);
            },
          ),
        ],
      ],
    );
  }
}