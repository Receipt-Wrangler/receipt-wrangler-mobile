import 'package:flutter/material.dart';

class SetHomeserverUrl extends StatefulWidget {
  const SetHomeserverUrl({super.key});

  @override
  State<SetHomeserverUrl> createState() => _SetHomeserverUrl();
}

class _SetHomeserverUrl extends State<SetHomeserverUrl> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      const SnackBar(content: Text("Invalid"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text("Set Homeserver URL"),
          TextFormField(
            decoration: const InputDecoration(label: Text("Homeserver URL")),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Text is required";
              }
              return null;
            },
          ),
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
