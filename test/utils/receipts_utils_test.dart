import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:receipt_wrangler_mobile/interfaces/form_item.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

void main() {
  group('getBytesFromEncodedImage', () {
    test('returns empty bytes for empty input', () {
      final result = getBytesFromEncodedImage('data:image/png;base64,');
      expect(result, isA<Uint8List>());
      expect(result.length, 0);
    });

    test('decodes base64 content after comma', () {
      final original = utf8.encode('hello world');
      final b64 = base64Encode(original);
      final dataUrl = 'data:text/plain;base64,' + b64;
      final bytes = getBytesFromEncodedImage(dataUrl);
      expect(bytes, equals(Uint8List.fromList(original)));
    });
  });

  group('calculateItemsTotal', () {
    FormItem buildItem({
      required String name,
      required String amount,
      int? chargedToUserId,
    }) {
      return FormItem(
        formId: 'id_$name',
        name: name,
        amount: amount,
        chargedToUserId: chargedToUserId,
        receiptId: 1,
        status: api.ItemStatus.OPEN,
        categories: const <api.Category>[],
        tags: const <api.Tag>[],
      );
    }

    test('sums only items without chargedToUserId', () {
      final items = [
        buildItem(name: 'A', amount: '10.5', chargedToUserId: null),
        buildItem(name: 'B', amount: '5.0', chargedToUserId: 123), // excluded
        buildItem(name: 'C', amount: '4.5', chargedToUserId: null),
      ];
      final total = calculateItemsTotal(items);
      expect(total, closeTo(15.0, 1e-9));
    });

    test('ignores items with unparsable amounts and continues', () {
      final items = [
        buildItem(name: 'A', amount: '10.0', chargedToUserId: null),
        buildItem(name: 'B', amount: 'abc', chargedToUserId: null), // unparsable
        buildItem(name: 'C', amount: '2', chargedToUserId: null),
      ];
      final total = calculateItemsTotal(items);
      expect(total, closeTo(12.0, 1e-9));
    });
  });
}

