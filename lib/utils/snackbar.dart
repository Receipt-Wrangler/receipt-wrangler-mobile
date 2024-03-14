import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';

void showSuccessSnackbar(BuildContext context, String message,
    {SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message), backgroundColor: Colors.green, action: action));
}

void showErrorSnackbar(BuildContext context, String message,
    {SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
    action: action,
  ));
}

void showApiErrorSnackbar(BuildContext context, ApiException error) {
  // TODO: fix
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(error.message ?? 'An error occured'),
    backgroundColor: Colors.red,
  ));
}
