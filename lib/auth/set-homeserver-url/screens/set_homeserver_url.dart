import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;
import 'package:receipt_wrangler_mobile/models/server_model.dart';

class SetHomeserverUrl extends StatefulWidget {
  const SetHomeserverUrl({super.key});

  @override
  State<SetHomeserverUrl> createState() => _SetHomeserverUrl();
}

class _SetHomeserverUrl extends State<SetHomeserverUrl> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Provider.of<ServerModel>(context, listen: false)
          .setBasePath(_formKey.currentState!.value["url"]);

      api.FeatureConfigApi()
          .getFeatureConfig()
          .then((value) => {
                print(value!.aiPoweredReceipts),
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Successfully connected to server"),
                  backgroundColor: Colors.green,
                )),
                context.go("/login"),
              })
          .catchError((error) => {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Failed to connect to server"),
                  backgroundColor: Colors.red,
                )),
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          const Text("Set Homeserver URL"),
          FormBuilderTextField(
              name: "url",
              decoration: const InputDecoration(labelText: "Homeserver URL"),
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
              child: const Text("Next"))
        ],
      ),
    );
  }
}
