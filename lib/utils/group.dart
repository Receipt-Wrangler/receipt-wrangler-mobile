import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String? getGroupId(BuildContext context) {
  return GoRouterState.of(context).pathParameters["groupId"];
}

String? getGroupByIdWithRouter(GoRouter router) {
  return router.routerDelegate.currentConfiguration.pathParameters["groupId"];
}
