import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';

class QuickAddShell extends StatefulWidget {
  const QuickAddShell({
    super.key,
    required this.title,
    required this.formKey,
    required this.formState,
    required this.isVisible,
    required this.onToggleVisibility,
    required this.onSubmit,
    required this.submitButtonText,
    required this.submitButtonIcon,
    required this.child,
    this.onSuccessCallback,
  });

  final String title;
  final GlobalKey<FormBuilderState> formKey;
  final WranglerFormState formState;
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onSubmit;
  final String submitButtonText;
  final IconData submitButtonIcon;
  final Widget child;
  final VoidCallback? onSuccessCallback;

  @override
  State<QuickAddShell> createState() => _QuickAddShellState();
}

class _QuickAddShellState extends State<QuickAddShell> {
  bool _isShowingSuccess = false;
  Timer? _successTimer;

  @override
  void dispose() {
    _successTimer?.cancel();
    super.dispose();
  }

  void _handleSubmit() {
    widget.onSubmit();
    _showSuccess();
  }

  void _showSuccess() {
    setState(() {
      _isShowingSuccess = true;
    });

    _successTimer?.cancel();
    _successTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isShowingSuccess = false;
        });
      }
    });

    widget.onSuccessCallback?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.formState == WranglerFormState.view) {
      return const SizedBox.shrink();
    }

    if (!widget.isVisible) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onToggleVisibility,
                    icon: const Icon(Icons.close, size: 20),
                    iconSize: 20,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              widget.child,
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isShowingSuccess ? null : _handleSubmit,
                  icon: Icon(_isShowingSuccess ? Icons.check : widget.submitButtonIcon),
                  label: Text(_isShowingSuccess ? "Added!" : widget.submitButtonText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isShowingSuccess 
                        ? Colors.green 
                        : Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}