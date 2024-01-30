import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';

void showSuccessSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
  ));
}

void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
  ));
}

void showApiErrorSnackbar(BuildContext context, ApiException error) {
  // TODO: fix
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(error.message ?? 'An error occured'),
    backgroundColor: Colors.red,
  ));
}


// TOOD: fix login issue
// TODO: store jwt in secure storage
// TODO: store refresh token in secure storage
// TODO: check if user is logged in, then move them to appropriate screen