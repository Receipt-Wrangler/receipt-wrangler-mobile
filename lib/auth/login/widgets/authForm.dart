import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/server_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/models/user_preferences_model.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _Login();
}

class _Login extends State<AuthForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    _formKey.currentState!.save();
    var form = _formKey.currentState!.value;

    if (_formKey.currentState!.validate()) {
      if (_isSignUp()) {
        var command = api.SignUpCommand(
            username: form["username"],
            password: form["password"],
            displayName: form["displayName"]);

        api.AuthApi()
            .signUp(command)
            .then((data) => showSuccessSnackbar(
                context, "${form["username"]} successfully signed up!"))
            .catchError((err) => showApiErrorSnackbar(context, err));
      } else {
        var command = api.LoginCommand(
            username: form["username"], password: form["password"]);

        api.AuthApi()
            .login(command)
            .then((data) => _storeAppData(data as api.AppData))
            .catchError((err) => showApiErrorSnackbar(context, err));
      }
    }
  }

  void _storeAppData(api.AppData appData) {
    Provider.of<AuthModel>(context, listen: false).setClaims(appData.claims);
    Provider.of<AuthModel>(context, listen: false)
        .setJwt(appData.jwt as String);
    Provider.of<AuthModel>(context, listen: false)
        .setRefreshToken(appData.refreshToken as String);

    Provider.of<GroupModel>(context, listen: false).setGroups(appData.groups);

    Provider.of<UserModel>(context, listen: false).setUsers(appData.users);

    Provider.of<UserPreferencesModel>(context, listen: false)
        .setUserPreferences(appData.userPreferences);
  }

  bool _isSignUp() {
    return GoRouter.of(context).routeInformationProvider.value.uri.toString() ==
        "/sign-up";
  }

  Widget _getDisplaynameField() {
    if (_isSignUp()) {
      return FormBuilderTextField(
          name: "displayName",
          decoration: const InputDecoration(labelText: "Displayname"),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]));
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _getHeaderText() {
    if (_isSignUp()) {
      return const Text("Sign Up");
    } else {
      return const Text("Login");
    }
  }

  Widget _getSignUpButton() {
    if (_isSignUp()) {
      return ElevatedButton(
          onPressed: () {
            context.go("/login");
          },
          style: TextButton.styleFrom(),
          child: const Text("Return to Login"));
    } else {
      return ElevatedButton(
          onPressed: () {
            context.go("/sign-up");
          },
          style: TextButton.styleFrom(),
          child: const Text("Sign Up"));
    }
  }

  Widget _getSubmitButtonText() {
    if (_isSignUp()) {
      return const Text("Sign Up");
    } else {
      return const Text("Login");
    }
  }

  Widget _getServerInfoText(ServerModel server) {
    if (_isSignUp()) {
      return Text('Signing up on: ${server.basePath}');
    }
    return Text('Logging into: ${server.basePath}');
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          _getHeaderText(),
          const SizedBox(
            height: 10,
          ),
          Consumer<ServerModel>(
            builder: (context, server, child) {
              return _getServerInfoText(server);
            },
          ),
          _getDisplaynameField(),
          FormBuilderTextField(
              name: "username",
              decoration: const InputDecoration(labelText: "Username"),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ])),
          FormBuilderTextField(
              name: "password",
              decoration: const InputDecoration(labelText: "Password"),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ])),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                _submit();
              },
              style: TextButton.styleFrom(),
              child: _getSubmitButtonText()),
          Consumer<ServerModel>(
            builder: (context, server, child) {
              if (server.featureConfig.enableLocalSignUp) {
                return _getSignUpButton();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
