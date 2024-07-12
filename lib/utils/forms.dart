import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api.dart';
import 'package:receipt_wrangler_mobile/models/loading_model.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';
import 'package:receipt_wrangler_mobile/utils/users.dart';

import '../enums/form_state.dart';
import '../models/group_model.dart';
import '../models/user_model.dart';

WranglerFormState getFormState(String uri) {
  if (uri.contains("add")) {
    return WranglerFormState.add;
  } else if (uri.contains("edit")) {
    return WranglerFormState.edit;
  } else {
    return WranglerFormState.view;
  }
}

WranglerFormState getFormStateFromContext(BuildContext context) {
  var uri = GoRouterState.of(context).uri;
  return getFormState(uri.toString());
}

String getFormStateHeader(WranglerFormState formState) {
  switch (formState) {
    case WranglerFormState.add:
      return "Add";
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
      .where((group) => !group.isAllGroup)
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

List<DropdownMenuItem> buildReceiptStatusDropDownMenuItems() {
  return const [
    DropdownMenuItem(
      value: ReceiptStatus.OPEN,
      child: Text("Open"),
    ),
    DropdownMenuItem(
      value: ReceiptStatus.NEEDS_ATTENTION,
      child: Text("Needs Attention"),
    ),
    DropdownMenuItem(
      value: ReceiptStatus.RESOLVED,
      child: Text("Resolved"),
    ),
    DropdownMenuItem(
      value: ReceiptStatus.DRAFT,
      child: Text("Draft"),
    ),
  ];
}

List<DropdownMenuItem> buildItemStatusDropDownMenuItems() {
  return const [
    DropdownMenuItem(
      value: ItemStatus.OPEN,
      child: Text("Open"),
    ),
    DropdownMenuItem(
      value: ItemStatus.RESOLVED,
      child: Text("Resolved"),
    ),
    DropdownMenuItem(
      value: ItemStatus.DRAFT,
      child: Text("Draft"),
    ),
  ];
}

setLoadingBarState(BuildContext context, bool isLoading) {
  Provider.of<LoadingModel>(context, listen: false).setIsLoading(isLoading);
}

handleApiError(BuildContext context, dynamic e) {
  if (e is ApiException) {
    showApiErrorSnackbar(context, e);
    return;
  }
}

bool isEditingBasedOnFullPath(String fullPath) {
  return fullPath.contains("edit") || fullPath.contains("add");
}
