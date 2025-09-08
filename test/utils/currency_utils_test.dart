import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/system_settings_model.dart';
import 'package:receipt_wrangler_mobile/utils/currency.dart';

Future<BuildContext> _pumpWithSettings(
  WidgetTester tester, {
  String symbol = 'X',
  api.CurrencySymbolPosition symbolPosition = api.CurrencySymbolPosition.END,
  bool hideDecimals = false,
  api.CurrencySeparator decimalSeparator = api.CurrencySeparator.period,
  api.CurrencySeparator thousandSeparator = api.CurrencySeparator.comma,
}) async {
  final model = SystemSettingsModel()
    ..setCurrencyDisplay(symbol)
    ..setCurrencySymbolPosition(symbolPosition)
    ..setCurrencyHideDecimalPlaces(hideDecimals)
    ..setCurrencyDecimalSeparator(decimalSeparator)
    ..setCurrencyThousandSeparator(thousandSeparator);

  BuildContext? ctx;
  await tester.pumpWidget(
    ChangeNotifierProvider<SystemSettingsModel>.value(
      value: model,
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            // Register currency immediately so tests can run lookups.
            registerCustomCurrency(context);
            ctx = context;
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return ctx!;
}

void main() {
  group('getCurrencySeparatorLiteral', () {
    test('returns proper literals', () {
      expect(getCurrencySeparatorLiteral(api.CurrencySeparator.comma), ',');
      expect(getCurrencySeparatorLiteral(api.CurrencySeparator.period), '.');
    });
  });

  group('getDefaultFormat', () {
    testWidgets('END symbol position with decimals', (tester) async {
      final ctx = await _pumpWithSettings(
        tester,
        symbol: 'X',
        symbolPosition: api.CurrencySymbolPosition.END,
        hideDecimals: false,
      );
      expect(getDefaultFormat(ctx), '###,###.00S');
    });

    testWidgets('START symbol position with decimals', (tester) async {
      final ctx = await _pumpWithSettings(
        tester,
        symbol: 'X',
        symbolPosition: api.CurrencySymbolPosition.START,
        hideDecimals: false,
      );
      expect(getDefaultFormat(ctx), 'S###,###.00');
    });

    testWidgets('END symbol position without decimals', (tester) async {
      final ctx = await _pumpWithSettings(
        tester,
        symbol: 'kr',
        symbolPosition: api.CurrencySymbolPosition.END,
        hideDecimals: true,
      );
      expect(getDefaultFormat(ctx), '###,###S');
    });

    testWidgets('START symbol position without decimals', (tester) async {
      final ctx = await _pumpWithSettings(
        tester,
        symbol: '€',
        symbolPosition: api.CurrencySymbolPosition.START,
        hideDecimals: true,
      );
      expect(getDefaultFormat(ctx), 'S###,###');
    });
  });

  group('registerCustomCurrency + exchange', () {
    testWidgets('exchangeUSDToCustom respects START symbol and separators',
        (tester) async {
      final ctx = await _pumpWithSettings(
        tester,
        symbol: '€',
        symbolPosition: api.CurrencySymbolPosition.START,
        hideDecimals: false,
        decimalSeparator: api.CurrencySeparator.period,
        thousandSeparator: api.CurrencySeparator.comma,
      );

      final result = exchangeUSDToCustom('1234.50');
      // START means symbol precedes amount
      expect(result.toString(), '€1,234.50');

      // formatCurrency uses the same under the hood
      expect(formatCurrency(ctx, '1234.50'), '€1,234.50');
    });

    testWidgets('exchangeUSDToCustom respects END symbol', (tester) async {
      final ctx = await _pumpWithSettings(
        tester,
        symbol: 'kr',
        symbolPosition: api.CurrencySymbolPosition.END,
        hideDecimals: false,
        decimalSeparator: api.CurrencySeparator.period,
        thousandSeparator: api.CurrencySeparator.comma,
      );

      final result = exchangeUSDToCustom('1234.50');
      // END means symbol follows amount
      expect(result.toString(), '1,234.50kr');
      expect(formatCurrency(ctx, '1234.50'), '1,234.50kr');
    });

    testWidgets('exchangeCustomToUSD parses custom with comma decimal',
        (tester) async {
      await _pumpWithSettings(
        tester,
        symbol: '€',
        symbolPosition: api.CurrencySymbolPosition.START,
        hideDecimals: false,
        decimalSeparator: api.CurrencySeparator.comma,
        thousandSeparator: api.CurrencySeparator.period,
      );

      // Custom format: 1.234,50 (thousand '.', decimal ',')
      final usd = exchangeCustomToUSD('1.234,50');
      expect(usd.toString(), endsWith('1234.50'));
    });

    testWidgets('exchangeCustomToUSD handles null/empty as zero',
        (tester) async {
      await _pumpWithSettings(
        tester,
        symbol: 'X',
        symbolPosition: api.CurrencySymbolPosition.START,
      );
      expect(exchangeCustomToUSD(null).toString(), endsWith('0.00'));
      expect(exchangeCustomToUSD('').toString(), endsWith('0.00'));
    });

    testWidgets('hide decimals in custom currency formatting', (tester) async {
      final ctx = await _pumpWithSettings(
        tester,
        symbol: '¥',
        symbolPosition: api.CurrencySymbolPosition.START,
        hideDecimals: true,
      );

      expect(getDefaultFormat(ctx), 'S###,###');
      // Even though USD value has cents, custom currency hides decimals
      final custom = exchangeUSDToCustom('1234.50');
      expect(custom.toString(), '¥1,235');
    });
  });
}
