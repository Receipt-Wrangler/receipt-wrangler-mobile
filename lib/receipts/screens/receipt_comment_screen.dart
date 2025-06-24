import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/receipt_model.dart';
import '../../enums/form_state.dart';
import '../widgets/receipt_comments.dart';

class ReceiptCommentScreen extends StatefulWidget {
  const ReceiptCommentScreen({super.key, required this.formState});
  
  final WranglerFormState formState;

  @override
  State<ReceiptCommentScreen> createState() => _ReceiptCommentScreenState();
}

class _ReceiptCommentScreenState extends State<ReceiptCommentScreen> {
  late final formState = widget.formState;
  late final receipt =
      Provider.of<ReceiptModel>(context, listen: false).receipt;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt Comments'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<ReceiptModel>(
        builder: (context, receiptModel, child) {
          return ReceiptComments(
            comments: receiptModel.comments,
            formState: formState,
          );
        },
      ),
    );
  }
}
