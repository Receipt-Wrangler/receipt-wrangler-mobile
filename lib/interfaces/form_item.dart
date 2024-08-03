import 'package:receipt_wrangler_mobile/api.dart' as api;
import 'package:uuid/uuid.dart';

class FormItem extends api.Item {
  final String formId;

  FormItem({
    required this.formId,
    required String name,
    required String amount,
    required int chargedToUserId,
    required int receiptId,
    required api.ItemStatus status,
  }) : super(
          name: name,
          amount: amount,
          chargedToUserId: chargedToUserId,
          receiptId: receiptId,
          status: status,
        );

  static FormItem fromItem(api.Item item) {
    return FormItem(
      formId: Uuid().v4(),
      name: item.name,
      amount: item.amount,
      chargedToUserId: item.chargedToUserId,
      receiptId: item.receiptId,
      status: item.status,
    );
  }

  static List<FormItem> fromItems(List<api.Item> items) {
    return items.map((item) => FormItem.fromItem(item)).toList();
  }

  static String buildItemNameName(FormItem item) {
    return "items.${item.formId}.name";
  }

  static String buildItemAmountName(FormItem item) {
    return "items.${item.formId}.amount";
  }

  static String buildItemStatusName(FormItem item) {
    return "items.${item.formId}.status";
  }
}
