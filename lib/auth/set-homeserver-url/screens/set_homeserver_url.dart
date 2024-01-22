import 'package:flutter/material.dart';

class SetHomeserverUrl extends StatefulWidget {
  const SetHomeserverUrl({super.key, required this.title});

  final String title;

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text("Set Homeserver URL"),
          TextFormField(
            decoration: const InputDecoration(label: Text("Homeserver URl")),
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
