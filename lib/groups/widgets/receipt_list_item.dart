import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/list_item_lead.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/slidable_edit_button.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/slidable_widget.dart';
import 'package:receipt_wrangler_mobile/utils/currency.dart';
import 'package:receipt_wrangler_mobile/utils/date.dart';

import '../../constants/colors.dart';
import '../../constants/theme.dart';
import '../../constants/spacing.dart';
import '../../models/auth_model.dart';
import '../../models/group_model.dart';
import '../../shared/functions/permissions.dart';
import '../../shared/widgets/list_item_trailing_status.dart';

class ReceiptListItem extends StatefulWidget {
  const ReceiptListItem(
      {super.key, required this.receipt, this.displayGroup = false});

  final api.Receipt receipt;

  final bool displayGroup;

  @override
  State<ReceiptListItem> createState() => _ReceiptListItem();
}

class _ReceiptListItem extends State<ReceiptListItem> {
  late final authModel = Provider.of<AuthModel>(context, listen: false);
  late final groupModel = Provider.of<GroupModel>(context, listen: false);

  Widget getStatusText() {
    var text = "";

    switch (widget.receipt.status) {
      case api.ReceiptStatus.DRAFT:
        text = "Draft";
      case api.ReceiptStatus.NEEDS_ATTENTION:
        text = "Needs Attention";
      case api.ReceiptStatus.OPEN:
        text = "Open";
      case api.ReceiptStatus.RESOLVED:
        text = "Resolved";
      default:
        throw Exception("Unknown status: ${widget.receipt.status}");
    }

    return ListItemTrailingStatus(color: getStatusColor(), text: text);
  }

  Widget getLeadingWidget() {
    return ListItemLead(
        date: widget.receipt.createdAt ?? "", color: getStatusColor());
  }

  Color getStatusColor() {
    switch (widget.receipt.status) {
      case api.ReceiptStatus.DRAFT:
        return gray500; // Much better contrast than light gray
      case api.ReceiptStatus.NEEDS_ATTENTION:
        return errorRed;
      case api.ReceiptStatus.OPEN:
        return const Color(0xFFF57C00); // Orange color for much better contrast
      case api.ReceiptStatus.RESOLVED:
        return const Color(0xFF2E7D32); // Darker green for better contrast
      default:
        throw Exception("Unknown status: ${widget.receipt.status}");
    }
  }

  Widget getSubtitleText() {
    var userNotFoundText = "User not found!";
    var userModel = Provider.of<UserModel>(context, listen: false);

    var user = userModel.getUserById(widget.receipt.paidByUserId.toString());
    var formattedAmount = formatCurrency(context, widget.receipt.amount);
    var formattedDate =
        formatDate(defaultDateFormat, DateTime.parse(widget.receipt.date));

    return Text(
      "${formattedAmount} paid by ${user?.displayName ?? userNotFoundText} on ${formattedDate}",
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: gray600,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildListTile() {
    var titleText = widget.receipt.name;

    if (widget.displayGroup) {
      var group = groupModel.getGroupById(widget.receipt.groupId.toString());
      titleText = "${widget.receipt.name}\n(${group?.name})";
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: space16,
        vertical: space8,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        boxShadow: cardShadow,
        border: Border.all(
          color: gray200,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: () => navigateToReceipt(WranglerFormState.view),
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        child: Padding(
          padding: cardPadding,
          child: Row(
            children: [
              getLeadingWidget(),
              const SizedBox(width: space16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: space8),
                    getSubtitleText(),
                  ],
                ),
              ),
              const SizedBox(width: space16),
              getStatusText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditButton() {
    return SlidableEditButton(
        onPressed: () => navigateToReceipt(WranglerFormState.edit));
  }

  void navigateToReceipt(WranglerFormState formState) {
    context.go("/receipts/${widget.receipt.id}/${formState.name}");
  }

  @override
  Widget build(BuildContext context) {
    var canEdit = canEditReceipt(authModel, groupModel, widget.receipt.groupId);

    return SlidableWidget(
        slideEnabled: canEdit,
        endActionPaneChildren: [buildEditButton()],
        slidableChild: buildListTile());
  }
}
