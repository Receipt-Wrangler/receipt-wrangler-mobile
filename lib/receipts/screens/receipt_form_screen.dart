import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/client/client.dart';
import 'package:receipt_wrangler_mobile/models/custom_field_model.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_app_bar.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_app_bar_action_builder.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_bottom_sheet_builder.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_form.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/circular_loading_progress.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

class ReceiptFormScreen extends StatefulWidget {
  const ReceiptFormScreen({super.key});

  @override
  State<ReceiptFormScreen> createState() => _ReceiptFormScreen();
}

class _ReceiptFormScreen extends State<ReceiptFormScreen> {
  bool _isLoading = true;
  bool _receiptLoaded = false;
  bool _hasLoadedData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoadedData) {
      _hasLoadedData = true;
      _loadData();
    }
  }

  Future<void> _loadData() async {
    var customFieldModel =
        Provider.of<CustomFieldModel>(context, listen: false);
    var state = GoRouterState.of(context);
    var receiptId = state.pathParameters['receiptId'] ?? "0";
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);

    try {
      // Create futures for both operations
      Future<void> customFieldsFuture = Future.value(null);
      if (!customFieldModel.isLoading) {
        customFieldsFuture =
            customFieldModel.loadCustomFields().catchError((error) {
          debugPrint('Custom fields loading failed: $error');
          return null; // Continue with empty custom fields
        });
      }

      Future<api.Receipt?> receiptFuture = Future.value(null);
      if (receiptId != "0" && !_receiptLoaded) {
        receiptFuture = OpenApiClient.client
            .getReceiptApi()
            .getReceiptById(
                receiptId:
                    int.parse(state.pathParameters['receiptId'] as String))
            .then((response) => response.data)
            .catchError((error) {
          debugPrint('Receipt loading failed: $error');
          throw error; // Receipt failure should trigger error state
        });
      }

      // Wait for both operations to complete
      final results = await Future.wait([
        customFieldsFuture,
        receiptFuture,
      ]);

      // Process receipt data if available
      final receiptData = results[1] as api.Receipt?;
      if (receiptData != null) {
        receiptModel.setReceipt(receiptData, false);
        _receiptLoaded = true;
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      debugPrint('Receipt loading failed: $error');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        showErrorSnackbar(context, 'Failed to load receipt');
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets? padding;

    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);

    var state = GoRouterState.of(context);
    var actionBuilder = ReceiptAppBarActionBuilder(context, receiptModel);
    var bottomSheetBuilder = ReceiptBottomSheetBuilder(context, receiptModel);

    print("building");

    var showChild = !_isLoading;

    return ScreenWrapper(
      appBarWidget:
          ReceiptAppBar(actions: actionBuilder.buildAppBarMenu(state)),
      bodyPadding: padding,
      bottomSheetWidget: bottomSheetBuilder.buildBottomSheet(state),
      child: showChild
          ? SingleChildScrollView(child: ReceiptForm())
          : const CircularLoadingProgress(),
    );
  }
}
