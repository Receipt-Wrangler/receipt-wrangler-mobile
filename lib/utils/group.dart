import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String? getGroupId(BuildContext context) {
  return GoRouterState.of(context).pathParameters["groupId"];
}
