import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class WranglerSearchBar extends StatefulWidget {
  const WranglerSearchBar({super.key});

  @override
  State<WranglerSearchBar> createState() => _WranglerSearchBar();
}

class _WranglerSearchBar extends State<WranglerSearchBar> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: FormBuilderTextField(
        name: "search",
        decoration: InputDecoration(label: Text("Search")),
      ),
    );
  }
}
