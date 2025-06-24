import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/receipt_model.dart';
import '../../enums/form_state.dart';
import '../widgets/receipt_comments.dart';
import '../widgets/receipt_comment_app_bar.dart';

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
      appBar: ReceiptCommentAppBar(
        formState: formState,
        title: 'Receipt Comments',
        onBack: () => Navigator.of(context).pop(),
        onEditMode: formState == WranglerFormState.view ? () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ReceiptCommentScreen(formState: WranglerFormState.edit),
            ),
          );
        } : null,
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
