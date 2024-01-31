import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import "package:receipt_wrangler_mobile/api/api.dart" as api;
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

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
      var authModel = Provider.of<AuthModel>(context, listen: false);

      authModel.setBasePath(_formKey.currentState!.value["url"]);

      api.FeatureConfigApi()
          .getFeatureConfig()
          .then((value) => {
                authModel.setFeatureConfig(value),
                showSuccessSnackbar(
                    context, "Successfully connected to server"),
                context.go("/login"),
              })
          .catchError((error) => {
                showErrorSnackbar(context, "Failed to connect to server"),
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    var serverModel = Provider.of<AuthModel>(context);

    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          const Text("Set Homeserver URL"),
          FormBuilderTextField(
              name: "url",
              decoration: const InputDecoration(labelText: "Homeserver URL"),
              initialValue: serverModel.basePath,
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
