import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';

class QuickAddShell extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    if (formState == WranglerFormState.view) {
      return const SizedBox.shrink();
    }

    if (!isVisible) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: onToggleVisibility,
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
              child,
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onSubmit,
                  icon: Icon(submitButtonIcon),
                  label: Text(submitButtonText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
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