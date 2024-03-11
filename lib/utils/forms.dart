import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/utils/users.dart';

import '../enums/form_state.dart';
import '../models/group_model.dart';
import '../models/user_model.dart';

WranglerFormState getFormState(String uri) {
  if (uri.contains("create")) {
    return WranglerFormState.create;
  } else if (uri.contains("edit")) {
    return WranglerFormState.edit;
  } else {
    return WranglerFormState.view;
  }
}

String getFormStateHeader(WranglerFormState formState) {
  switch (formState) {
    case WranglerFormState.create:
      return "Create";
    case WranglerFormState.edit:
      return "Edit";
    case WranglerFormState.view:
      return "View";
    default:
      return "View";
  }
}

bool isFieldReadOnly(WranglerFormState formState) {
  return formState == WranglerFormState.view;
}

List<DropdownMenuItem> buildGroupDropDownMenuItems(BuildContext context) {
  var groups = Provider.of<GroupModel>(context, listen: false).groups;
  return groups
      .map((group) => DropdownMenuItem(
            value: group.id,
            child: Text(group.name),
          ))
      .toList();
}

List<DropdownMenuItem> buildGroupMemberDropDownMenuItems(
    BuildContext context, String groupId) {
  if (groupId.isEmpty) {
    return [];
  }

  var userModel = Provider.of<UserModel>(context, listen: false);
  var groupModel = Provider.of<GroupModel>(context, listen: false);

  return getUsersInGroup(userModel, groupModel, groupId)
      .map((user) => DropdownMenuItem(
            value: user.id,
            child: Text(user.displayName),
          ))
      .toList();
}
