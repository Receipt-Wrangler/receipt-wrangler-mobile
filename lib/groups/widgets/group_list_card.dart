import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:receipt_wrangler_mobile/constants/theme.dart';
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/constants/colors.dart';

class GroupListCard extends StatefulWidget {
  const GroupListCard(
      {super.key, required this.group, required this.onGroupTap});

  final api.Group group;

  final void Function(api.Group group) onGroupTap;

  @override
  State<GroupListCard> createState() => _GroupListCard();
}

class _GroupListCard extends State<GroupListCard> {
  @override
  Widget build(BuildContext context) {
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
        onTap: () => widget.onGroupTap(widget.group),
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        child: Padding(
          padding: cardPadding,
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(39, 177, 255, 0.1),
                  borderRadius: BorderRadius.circular(borderRadiusMedium),
                ),
                child: const Icon(
                  Icons.group,
                  color: primaryBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: space16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.group.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: space4),
                    Text(
                      'Tap to select group',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: gray600,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: gray400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
