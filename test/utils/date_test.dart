import 'package:flutter_test/flutter_test.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';

void main() {
  group('formatDate', () {
    test('formats with defaultDateFormat (local date)', () {
      final date = DateTime(2024, 1, 2, 15, 30);
      final formatted = formatDate(defaultDateFormat, date);
      expect(formatted, equals('01/02/2024'));
    });

    test('formats with zuluDateFormat pattern', () {
      // Using a date already in local time to avoid timezone differences.
      final date = DateTime(2024, 6, 15, 8, 5, 9);
      final formatted = formatDate(zuluDateFormat, date);
      // Pattern is yyyy-MM-dd'T'HH:mm:ss'Z' and should reflect local hour/min/sec
      final hh = date.hour.toString().padLeft(2, '0');
      final mm = date.minute.toString().padLeft(2, '0');
      final ss = date.second.toString().padLeft(2, '0');
      expect(formatted, equals('2024-06-15' "T" '$hh:$mm:$ss' 'Z'));
    });
  });
}

