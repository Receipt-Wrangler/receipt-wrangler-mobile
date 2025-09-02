import 'package:flutter_test/flutter_test.dart';
import 'package:receipt_wrangler_mobile/interfaces/form_item.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:openapi/openapi.dart' as api;

FormItem _item({
  required String id,
  required String name,
  required String amount,
  int? chargedToUserId,
}) {
  return FormItem(
    formId: id,
    name: name,
    amount: amount,
    chargedToUserId: chargedToUserId,
    receiptId: 1,
    status: api.ItemStatus.OPEN,
    categories: const <api.Category>[],
    tags: const <api.Tag>[],
  );
}

void main() {
  group('ReceiptModel totals and sync', () {
    test('setSyncWithItems recalculates amount from non-shared items only', () {
      final model = ReceiptModel();

      final items = [
        _item(id: 'a', name: 'A', amount: '10.50'), // included
        _item(id: 'b', name: 'B', amount: '5.50', chargedToUserId: 123), // share -> excluded
        _item(id: 'c', name: 'C', amount: '4.00'), // included
      ];

      model.setItems(items);

      // Not synced yet, amount should remain default '0'
      expect(model.modifiedReceipt.amount, '0');

      model.setSyncWithItems(true);
      expect(model.syncWithItems, isTrue);
      // 10.50 + 4.00 = 14.50
      expect(model.modifiedReceipt.amount, '14.50');
    });

    test('setItems updates total only when sync enabled', () {
      final model = ReceiptModel();

      final items1 = [
        _item(id: 'a', name: 'A', amount: '1.00'),
      ];

      model.setItems(items1);
      expect(model.modifiedReceipt.amount, '0');

      model.setSyncWithItems(true);
      expect(model.modifiedReceipt.amount, '1.00');

      final items2 = [
        _item(id: 'a', name: 'A', amount: '1.00'),
        _item(id: 'b', name: 'B', amount: '0.30'),
      ];
      model.setItems(items2);
      expect(model.modifiedReceipt.amount, '1.30');
    });

    test('amount rounding uses two decimals (0.1 + 0.2 = 0.30)', () {
      final model = ReceiptModel();

      model.setItems([
        _item(id: 'a', name: 'A', amount: '0.10'),
        _item(id: 'b', name: 'B', amount: '0.20'),
      ]);

      model.setSyncWithItems(true);
      expect(model.modifiedReceipt.amount, '0.30');
    });
  });

  group('ReceiptModel reset and quick actions context', () {
    test('resetModel clears items, comments, images and flags', () {
      final model = ReceiptModel();
      model.setItems([
        _item(id: 'a', name: 'A', amount: '1.00'),
      ]);
      model.setComments([]);
      model.setSyncWithItems(true);
      model.setSplitAmount('5.00');
      model.setSplitItemFormId('item-1');

      expect(model.items, isNotEmpty);
      expect(model.syncWithItems, isTrue);
      expect(model.splitAmount, '5.00');
      expect(model.splitItemFormId, 'item-1');

      model.resetModel();

      expect(model.items, isEmpty);
      expect(model.syncWithItems, isFalse);
      expect(model.splitAmount, isNull);
      expect(model.splitItemFormId, isNull);
      expect(model.imageBehaviorSubject.value, isEmpty);
      expect(model.imagesToUploadBehaviorSubject.value, isEmpty);
    });

    test('resetQuickActionsFormKey clears split context only', () {
      final model = ReceiptModel();
      model.setSplitAmount('12.34');
      model.setSplitItemFormId('abc');

      expect(model.splitAmount, '12.34');
      expect(model.splitItemFormId, 'abc');

      model.resetQuickActionsFormKey();

      expect(model.splitAmount, isNull);
      expect(model.splitItemFormId, isNull);
      // does not touch receipt or items
      expect(model.items, isEmpty);
    });
  });
}

