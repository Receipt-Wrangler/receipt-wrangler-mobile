import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/amount_field.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/category_select_field.dart';
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
    if (widget.formState == WranglerFormState.view) {
      return const SizedBox.shrink();
    }

    if (!widget.isVisible) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _quickAddFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quick Add Item",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onToggleVisibility,
                    icon: const Icon(Icons.close, size: 20),
                    iconSize: 20,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Item"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}