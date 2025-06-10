import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/loading_model.dart';
import 'package:receipt_wrangler_mobile/constants/theme.dart';
import 'package:receipt_wrangler_mobile/constants/spacing.dart';

class BottomSubmitButton extends StatefulWidget {
  const BottomSubmitButton(
      {super.key, required this.onPressed, this.buttonText, this.disabled});

  final String? buttonText;

  final disabled;

  final void Function() onPressed;

  @override
  State<BottomSubmitButton> createState() => _BottomSubmitButtonState();
}

class _BottomSubmitButtonState extends State<BottomSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Consumer<LoadingModel>(
        builder: (context, loadingModel, child) {
          return ElevatedButton(
            onPressed: (loadingModel.isLoading || (widget.disabled ?? false))
                ? null
                : widget.onPressed,
            style: ElevatedButton.styleFrom(
              elevation: elevationLow,
              shape: buttonShape,
              padding: const EdgeInsets.symmetric(
                vertical: space12,
                horizontal: space24,
              ),
            ),
            child: loadingModel.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    widget.buttonText ?? "Submit",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
          );
        },
      ),
    );
  }
}
