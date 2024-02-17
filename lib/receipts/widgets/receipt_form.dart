import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/enums/form_state.dart';

class ReceiptForm extends StatefulWidget {
  const ReceiptForm(
      {super.key, required this.receipt, required this.formState});

  final api.Receipt receipt;

  final WranglerFormState formState;

  @override
  State<ReceiptForm> createState() => _ReceiptForm();
}

class _ReceiptForm extends State<ReceiptForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [Text("hello")],
      ),
    );
  }
}
