import 'package:flutter_test/flutter_test.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

void main() {
  group('getFormState', () {
    test('detects add', () {
      expect(getFormState('/receipts/add'), WranglerFormState.add);
      expect(getFormState('/receipts/123/add'), WranglerFormState.add);
    });
    test('detects edit', () {
      expect(getFormState('/receipts/1/edit'), WranglerFormState.edit);
    });
    test('defaults to view', () {
      expect(getFormState('/receipts/1/view'), WranglerFormState.view);
      expect(getFormState('/receipts/1'), WranglerFormState.view);
    });
  });

  group('getFormStateHeader', () {
    test('returns proper headers', () {
      expect(getFormStateHeader(WranglerFormState.add), 'Add');
      expect(getFormStateHeader(WranglerFormState.edit), 'Edit');
      expect(getFormStateHeader(WranglerFormState.view), 'View');
    });
  });

  group('isFieldReadOnly', () {
    test('only view is read-only', () {
      expect(isFieldReadOnly(WranglerFormState.view), isTrue);
      expect(isFieldReadOnly(WranglerFormState.add), isFalse);
      expect(isFieldReadOnly(WranglerFormState.edit), isFalse);
    });
  });

  group('formatDateBasedOnFormState', () {
    test('returns string as-is for view', () {
      final input = '2024-01-02';
      final result = formatDateBasedOnFormState(WranglerFormState.view, input);
      expect(result, equals(input));
    });

    test('returns DateTime for add/edit', () {
      final input = '2024-01-02';
      final addResult = formatDateBasedOnFormState(WranglerFormState.add, input);
      final editResult = formatDateBasedOnFormState(WranglerFormState.edit, input);
      expect(addResult, isA<DateTime>());
      expect(editResult, isA<DateTime>());
      expect((addResult as DateTime).year, 2024);
      expect((addResult).month, 1);
      expect((addResult).day, 2);
    });
  });

  group('convertDateFormatForForm', () {
    test('converts MM/dd/yyyy to zuluDateFormat', () {
      final input = '01/02/2024';
      final result = convertDateFormatForForm(input);
      // Expect yyyy-MM-dd'T'HH:mm:ss'Z' at 00:00:00 local in zulu
      // The original util uses a fixed zulu pattern; it formats the parsed
      // date at local midnight into a Z-suffixed string.
      expect(result.startsWith('2024-01-02T'), isTrue);
      expect(result.endsWith('Z'), isTrue);
    });
  });
}

