import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/auth/login/widgets/auth_form.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(children: [AuthForm()]);
  }
}