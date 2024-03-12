import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/constants/spacing.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

import '../../models/user_preferences_model.dart';

class QuickScan extends StatefulWidget {
  const QuickScan({super.key, required this.imageStream});

  final Stream<MultipartFile?> imageStream;

  @override
  State<QuickScan> createState() => _QuickScan();
}

class _QuickScan extends State<QuickScan> {
  final _formKey = GlobalKey<FormBuilderState>();
  MultipartFile? image;
  int groupId = 0;

  @override
  initState() {
    super.initState();
    var userPreferencesModel =
        Provider.of<UserPreferencesModel>(context, listen: false);

    groupId = userPreferencesModel.userPreferences.quickScanDefaultGroupId;

    widget.imageStream.listen((event) {
      setState(() {
        image = event;
      });
    });
  }

  Widget _buildGroupField(api.UserPreferences userPreferences) {
    int? initialValue;

    if (userPreferences.quickScanDefaultGroupId > 0) {
      initialValue = userPreferences.quickScanDefaultGroupId;
    }

    return FormBuilderDropdown(
      name: "groupId",
      decoration: const InputDecoration(labelText: "Group"),
      initialValue: initialValue,
      items: buildGroupDropDownMenuItems(context),
      validator: FormBuilderValidators.required(),
      onChanged: (value) {
        setState(() {
          _formKey.currentState!.fields["paidByUserId"]!.setValue(null);
          groupId = value as int;
        });
      },
    );
  }

  Widget _buildUserDropDown(api.UserPreferences userPreferences) {
    List<DropdownMenuItem> items = [];
    int? initialValue;

    if (groupId > 0) {
      items = buildGroupMemberDropDownMenuItems(context, groupId.toString());
    }

    if (groupId == userPreferences.quickScanDefaultGroupId &&
        userPreferences.userId > 0) {
      initialValue = userPreferences.quickScanDefaultPaidById;
    }

    return FormBuilderDropdown(
      name: "paidByUserId",
      decoration: const InputDecoration(labelText: "Paid By"),
      items: items,
      validator: FormBuilderValidators.required(),
      initialValue: initialValue,
    );
  }

  Widget _buildStatusDropdown(api.UserPreferences userPreferences) {
    api.ReceiptStatus? initialValue;
    var userPreferencesModel =
        Provider.of<UserPreferencesModel>(context, listen: false);

    if (userPreferencesModel.userPreferences.quickScanDefaultStatus != null) {
      initialValue =
          userPreferencesModel.userPreferences.quickScanDefaultStatus;
    }

    return FormBuilderDropdown(
      name: "status",
      decoration: const InputDecoration(labelText: "Status"),
      items: buildStatusDropDownMenuItems(),
      validator: FormBuilderValidators.required(),
      initialValue: initialValue,
    );
  }

  Widget _buildImagePreview() {
    if (image != null) {
      print(image);
      var byteFuture = image!.finalize().toBytes();
      return FutureBuilder(
          future: byteFuture,
          builder: (context, snapshot) {
            print("data");
            print(snapshot.data);
            if (snapshot.hasData) {
              return Image.memory(snapshot.data as Uint8List);
            }
            return const CircularProgressIndicator();
          });
    }
    return const Text("No Image");
  }

  @override
  Widget build(BuildContext context) {
    var userPreferences =
        Provider.of<UserPreferencesModel>(context, listen: false)
            .userPreferences;
    return FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            _buildImagePreview(),
            textFieldSpacing,
            _buildGroupField(userPreferences),
            textFieldSpacing,
            _buildUserDropDown(userPreferences),
            textFieldSpacing,
            _buildStatusDropdown(userPreferences),
          ],
        ));
  }
}
