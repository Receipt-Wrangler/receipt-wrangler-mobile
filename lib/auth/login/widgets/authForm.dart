import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;
import 'package:receipt_wrangler_mobile/models/server_model.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _Login();
}

class _Login extends State<AuthForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var form = _formKey.currentState!.value;

      var command = api.LoginCommand(
          username: form["username"], password: form["password"]);

      api.AuthApi()
          .login(command)
          .then((data) => print(data))
          .catchError((err) => print(err));
    }
  }

  bool _isSignUp() {
    return GoRouter.of(context)
            .routeInformationProvider!
            .value
            .uri
            .toString() ==
        "/sign-up";
  }

  Widget _getDisplaynameField() {
    if (_isSignUp()) {
      return FormBuilderTextField(
          name: "displayname",
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
              return Text('Logging into: ${server.basePath}');
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
