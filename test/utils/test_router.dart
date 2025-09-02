import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRouter buildTestRouter({
  required String initialLocation,
  required WidgetBuilder builder,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/receipts/add',
        builder: (context, state) => builder(context),
      ),
      GoRoute(
        path: '/receipts/:id/view',
        builder: (context, state) => builder(context),
      ),
      GoRoute(
        path: '/receipts/:id/edit',
        builder: (context, state) => builder(context),
      ),
    ],
  );
}

