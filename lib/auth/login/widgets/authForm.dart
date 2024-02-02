import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/models/user_preferences_model.dart';
import 'package:receipt_wrangler_mobile/utils/auth.dart';
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
            .then((data) => _onLoginSuccess(data as api.AppData))
            .catchError((err) => showApiErrorSnackbar(context, err));
      }
    }
  }

  void _onLoginSuccess(api.AppData appData) {
    var authModel = Provider.of<AuthModel>(context, listen: false);
    var groupModel = Provider.of<GroupModel>(context, listen: false);
    var userModel = Provider.of<UserModel>(context, listen: false);
    var userPreferencesModel =
        Provider.of<UserPreferencesModel>(context, listen: false);

    storeAppData(
        authModel, groupModel, userModel, userPreferencesModel, appData);
    showSuccessSnackbar(context, "Successfully logged in!");
    context.go("/groups");
  }

  bool _isSignUp() {
    return GoRouter.of(context).routeInformationProvider.value.uri.toString() ==
        "/sign-up";
  }

  Widget _getDisplaynameField() {
    if (_isSignUp()) {
      return FormBuilderTextField(
          name: "displayName",
          decoration: const InputDecoration(
              labelText: "Displayname", border: OutlineInputBorder()),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]));
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _getHeaderText() {
    var headerText = _isSignUp() ? "Create Account" : "Login";

    return Text(
      headerText,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _getSignUpButton() {
    var route = "";
    var buttonText = "";

    if (_isSignUp()) {
      route = "/login";
      buttonText = "Return to Login";
    } else {
      route = "/sign-up";
      buttonText = "Create an Account";
    }

    return CupertinoButton(
        onPressed: () {
          context.go(route);
        },
        child: Text(buttonText));
  }

  Widget _getSubmitButtonText() {
    if (_isSignUp()) {
      return const Text("Create an Account");
    } else {
      return const Text("Log in");
    }
  }

  Widget _getServerInfoText(AuthModel server) {
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
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return _getServerInfoText(auth);
            },
          ),
          headerSpacing,
          _getDisplaynameField(),
          _isSignUp() ? textFieldSpacing : const SizedBox.shrink(),
          FormBuilderTextField(
              name: "username",
              decoration: const InputDecoration(
                  labelText: "Username", border: OutlineInputBorder()),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ])),
          textFieldSpacing,
          FormBuilderTextField(
              name: "password",
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "Password", border: OutlineInputBorder()),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ])),
          lastFieldSpacing,
          Row(
            children: [
              Expanded(
                child: CupertinoButton.filled(
                    onPressed: () {
                      _submit();
                    },
                    child: _getSubmitButtonText()),
              )
            ],
          ),
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              if (auth.featureConfig.enableLocalSignUp) {
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
