import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/system_settings_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/amount_field.dart';
import 'package:receipt_wrangler_mobile/utils/currency.dart';

Future<(WidgetTester, GlobalKey<FormBuilderState>)> _pumpWithSettings(
  WidgetTester tester, {
  required String symbol,
  required api.CurrencySymbolPosition position,
  bool hideDecimals = false,
  api.CurrencySeparator decimalSeparator = api.CurrencySeparator.period,
  api.CurrencySeparator thousandSeparator = api.CurrencySeparator.comma,
  String initialAmount = '0.00',
  WranglerFormState formState = WranglerFormState.edit,
}) async {
  final key = GlobalKey<FormBuilderState>();
  final model = SystemSettingsModel()
    ..setCurrencyDisplay(symbol)
    ..setCurrencySymbolPosition(position)
    ..setCurrencyHideDecimalPlaces(hideDecimals)
    ..setCurrencyDecimalSeparator(decimalSeparator)
    ..setCurrencyThousandSeparator(thousandSeparator);

  await tester.pumpWidget(
    ChangeNotifierProvider<SystemSettingsModel>.value(
      value: model,
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            // Register custom currency for Money2 parsing/formatting
            registerCustomCurrency(context);
            return Scaffold(
              body: FormBuilder(
                key: key,
                child: AmountField(
                  label: 'Amount',
                  fieldName: 'amount',
                  initialAmount: initialAmount,
                  formState: formState,
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return (tester, key);
}

void main() {
  group('AmountField - valueTransformer and formatting', () {
    testWidgets('transforms custom input to USD numeric string', (tester) async {
      final (t, key) = await _pumpWithSettings(
        tester,
        symbol: '€',
        position: api.CurrencySymbolPosition.START,
        hideDecimals: false,
        decimalSeparator: api.CurrencySeparator.period,
        thousandSeparator: api.CurrencySeparator.comma,
      );

      // Enter value with thousand and decimal separators
      await t.enterText(find.byType(TextField), '1,234.50');
      await t.pumpAndSettle();

      expect(key.currentState!.saveAndValidate(), isTrue);
      // Should normalize to plain USD numeric with two decimals
      expect(key.currentState!.value['amount'], equals('1234.50'));
    });

    testWidgets('respects hideDecimals: parses integer input and outputs .00 in USD', (tester) async {
      final (t, key) = await _pumpWithSettings(
        tester,
        symbol: '¥',
        position: api.CurrencySymbolPosition.START,
        hideDecimals: true,
        decimalSeparator: api.CurrencySeparator.period,
        thousandSeparator: api.CurrencySeparator.comma,
      );

      // When decimals are hidden, user enters whole amounts (no decimals)
      await t.enterText(find.byType(TextField), '1,235');
      await t.pumpAndSettle();

      expect(key.currentState!.saveAndValidate(), isTrue);
      // With hideDecimals, custom value 1235 becomes 1235.00 in USD
      expect(key.currentState!.value['amount'], equals('1235.00'));
    });
  });

  group('AmountField - readOnly and decoration', () {
    testWidgets('readOnly in view mode', (tester) async {
      final (t, _) = await _pumpWithSettings(
        tester,
        symbol: '€',
        position: api.CurrencySymbolPosition.START,
        formState: WranglerFormState.view,
      );

      final tf = tester.widget<TextField>(find.byType(TextField));
      expect(tf.readOnly, isTrue);
    });

    testWidgets('prefix/suffix from SystemSettingsModel by symbol position', (tester) async {
      // START => prefix
      await _pumpWithSettings(
        tester,
        symbol: '€',
        position: api.CurrencySymbolPosition.START,
      );
      var tf = tester.widget<TextField>(find.byType(TextField));
      expect(tf.decoration?.prefixText, equals('€'));
      expect(tf.decoration?.suffixText, isNull);

      // END => suffix
      await _pumpWithSettings(
        tester,
        symbol: 'kr',
        position: api.CurrencySymbolPosition.END,
      );
      tf = tester.widget<TextField>(find.byType(TextField));
      expect(tf.decoration?.prefixText, isNull);
      expect(tf.decoration?.suffixText, equals('kr'));
    });
  });
}
