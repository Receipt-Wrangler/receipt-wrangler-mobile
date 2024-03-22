import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/loading_model.dart';

class BottomSubmitButton extends StatefulWidget {
  const BottomSubmitButton({super.key, required this.onPressed});

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
          return MaterialButton(
            onPressed: loadingModel.isLoading ? null : widget.onPressed,
            color: Theme.of(context).primaryColor,
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
