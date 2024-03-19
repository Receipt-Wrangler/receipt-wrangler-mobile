import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api.dart" as api;
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/user_avatar.dart';

void main() {
  Widget createTestableWidget(
      {String? userId,
      required UserModel userModel,
      required AuthModel authModel}) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserModel>.value(value: userModel),
          ChangeNotifierProvider<AuthModel>.value(value: authModel),
        ],
        child: Scaffold(body: UserAvatar(userId: userId)),
      ),
    );
  }

  testWidgets('Displays correct initial for provided userId',
      (WidgetTester tester) async {
    final userModel = UserModel();
    userModel.setUsers([
      api.UserView(
          id: 1,
          displayName: 'Jane Doe',
          username: "jane_doe",
          isDummyUser: false,
          userRole: api.UserRole.USER)
    ]);
    final authModel = AuthModel();

    await tester.pumpWidget(createTestableWidget(
        userId: '1', userModel: userModel, authModel: authModel));
    expect(find.text('J'), findsOneWidget);
  });

  testWidgets('Displays correct initial when no userId is provided',
      (WidgetTester tester) async {
    final userModel = UserModel();
    final authModel = AuthModel();
    final claims = api.Claims(
        displayName: 'Jane Doe',
        userId: 1,
        userRole: api.UserRole.USER,
        username: 'jane_doe',
        defaultAvatarColor: "",
        iss: "",
        exp: 0);

    authModel.setClaims(claims);

    await tester.pumpWidget(
        createTestableWidget(userModel: userModel, authModel: authModel));

    expect(find.text('J'), findsOneWidget);
  });
}
