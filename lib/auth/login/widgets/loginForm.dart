import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _Login();
}

class _Login extends State<LoginForm> {
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

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          const Text("Login"),
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
              child: const Text("Login"))
        ],
      ),
    );
  }
}
