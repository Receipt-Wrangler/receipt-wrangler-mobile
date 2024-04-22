import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/receipt_model.dart';
import '../../utils/forms.dart';
import '../widgets/receipt_comments.dart';

class ReceiptCommentScreen extends StatefulWidget {
  const ReceiptCommentScreen({super.key});

  @override
  State<ReceiptCommentScreen> createState() => _ReceiptCommentScreenState();
}

class _ReceiptCommentScreenState extends State<ReceiptCommentScreen> {
  late final formState = getFormStateFromContext(context);
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
    return Consumer<ReceiptModel>(
      builder: (context, receiptModel, child) {
        return ReceiptComments(
          comments: receiptModel.comments,
        );
      },
    );
  }
}
