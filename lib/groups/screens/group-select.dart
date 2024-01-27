import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/auth/set-homeserver-url/screens/set_homeserver_url.dart';
import 'package:receipt_wrangler_mobile/models/layout_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screenWrapper.dart';

class GroupSelect extends StatefulWidget {
  const GroupSelect({super.key});

  @override
  State<GroupSelect> createState() => _GroupSelect();
}

class _GroupSelect extends State<GroupSelect> {
  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(children: [const Text("welcome to groups")]);
  }
}
