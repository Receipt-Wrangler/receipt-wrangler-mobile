import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/loading_model.dart';

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
      height: 50,
      child: Consumer<LoadingModel>(
        builder: (context, loadingModel, child) {
          final isBusy = loadingModel.isLoading || (widget.disabled ?? false);
          return MaterialButton(
            onPressed: isBusy ? null : widget.onPressed,
            color: Theme.of(context).primaryColor,
            child: isBusy
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.buttonText ?? "Submitting...",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                : Text(
                    widget.buttonText ?? "Submit",
                    style: const TextStyle(color: Colors.white),
                  ),
          );
        },
      ),
    );
  }
}
