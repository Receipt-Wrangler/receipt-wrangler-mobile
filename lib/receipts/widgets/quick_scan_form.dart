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

class QuickScanForm extends StatefulWidget {
  const QuickScanForm(
      {super.key, required this.imageStream, required this.formKey});

  final GlobalKey<FormBuilderState> formKey;

  final Stream<MultipartFile?> imageStream;

  @override
  State<QuickScanForm> createState() => _QuickScanForm();
}

class _QuickScanForm extends State<QuickScanForm> {
  MultipartFile? image;
  Uint8List? bytes;
  int groupId = 0;

  @override
  initState() {
    super.initState();
    var userPreferencesModel =
        Provider.of<UserPreferencesModel>(context, listen: false);

    groupId = userPreferencesModel.userPreferences.quickScanDefaultGroupId;

    widget.imageStream.listen((event) {
      setState(() {
        if (event != image) {
          bytes = null;
          image = event;
        }
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
          widget.formKey.currentState!.fields["paidByUserId"]!.setValue(null);
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
    if (bytes != null) {
      return Image.memory(bytes as Uint8List);
    }

    if (image != null) {
      var byteFuture = image!.finalize().toBytes();
      return FutureBuilder(
          future: byteFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              bytes = snapshot.data;
              return Image.memory(snapshot.data as Uint8List);
            }
            return const CircularProgressIndicator();
          });
    }
    return const Text("Select an image to scan.");
  }

  @override
  Widget build(BuildContext context) {
    var userPreferences =
        Provider.of<UserPreferencesModel>(context, listen: false)
            .userPreferences;
    return FormBuilder(
        key: widget.formKey,
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
