import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/auth/set-homeserver-url/screens/set_homeserver_url.dart';
import 'package:receipt_wrangler_mobile/models/layout_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screenWrapper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(children: [SetHomeserverUrl()]);
  }
}
