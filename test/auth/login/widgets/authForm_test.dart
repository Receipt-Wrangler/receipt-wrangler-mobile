import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/auth/login/screens/authScreen.dart';
import 'package:receipt_wrangler_mobile/auth/login/widgets/auth_form.dart';

void main() {
  testWidgets('authForm ...', (tester) async {
    var routes = [
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthScreen(),
      ),
    ];
    await tester.pumpWidget(MaterialApp.router(
        title: 'Receipt Wrangler',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: GoRouter(routes: routes, initialLocation: '/login')));

    expect(find.byType(AuthForm), findsOneWidget);
  });
}
