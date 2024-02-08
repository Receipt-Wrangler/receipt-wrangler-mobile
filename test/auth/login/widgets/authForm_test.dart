import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/auth/login/widgets/auth_form.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/models/user_preferences_model.dart';

void main() {
  Widget createTestableWidget({
    required UserModel userModel,
    required AuthModel authModel,
    required GroupModel groupModel,
    required UserPreferencesModel userPreferencesModel,
  }) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserModel>.value(value: userModel),
          ChangeNotifierProvider<AuthModel>.value(value: authModel),
          ChangeNotifierProvider<GroupModel>.value(value: groupModel),
          ChangeNotifierProvider<UserPreferencesModel>.value(
              value: userPreferencesModel),
        ],
        child: const Scaffold(body: AuthForm()),
      ),
    );
  }

  testWidgets('Displays correct initial for provided userId',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(
      userModel: UserModel(),
      authModel: AuthModel(),
      groupModel: GroupModel(),
      userPreferencesModel: UserPreferencesModel(),
    ));

    expect(find.text("Log"), findsOneWidget);
  });
}
