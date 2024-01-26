import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/auth/login/screens/authScreen.dart';
import 'package:receipt_wrangler_mobile/auth/login/widgets/authForm.dart';
import 'package:receipt_wrangler_mobile/auth/set-homeserver-url/screens/set_homeserver_url.dart';
import 'package:receipt_wrangler_mobile/home/screens/home.dart';
import 'package:receipt_wrangler_mobile/models/layout_model.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/models/server_model.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LayoutModel()),
      ChangeNotifierProvider(create: (_) => ServerModel())
    ],
    child: const ReceiptWrangler(),
  ));
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const AuthScreen(),
    ),
  ],
);

class ReceiptWrangler extends StatelessWidget {
  const ReceiptWrangler({super.key});

  @override
  Widget build(BuildContext context) {
    var serverState = Provider.of<ServerModel>(context, listen: true);
    api.defaultApiClient = api.ApiClient(basePath: serverState.basePath);

    return MaterialApp.router(
      title: 'Receipt Wrangler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
