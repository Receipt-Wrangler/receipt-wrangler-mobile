import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/auth/login/screens/auth_screen.dart';
import 'package:receipt_wrangler_mobile/groups/screens/group-select.dart';
import 'package:receipt_wrangler_mobile/groups/screens/group_home.dart';
import 'package:receipt_wrangler_mobile/guards/auth-guard.dart';
import 'package:receipt_wrangler_mobile/home/screens/home.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/layout_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/models/user_preferences_model.dart';
import 'package:receipt_wrangler_mobile/persistence/global_shared_preferences.dart';
import 'package:receipt_wrangler_mobile/utils/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalSharedPreferences.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LayoutModel()),
      ChangeNotifierProvider(create: (_) => AuthModel()),
      ChangeNotifierProvider(create: (_) => GroupModel()),
      ChangeNotifierProvider(create: (_) => UserModel()),
      ChangeNotifierProvider(create: (_) => UserPreferencesModel()),
    ],
    child: const ReceiptWrangler(),
  ));
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Home(),
      redirect: (context, state) {
        return unprotectedRouteRedirect(context, "/groups");
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const AuthScreen(),
      redirect: (context, state) {
        return unprotectedRouteRedirect(context, "/groups");
      },
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const AuthScreen(),
      redirect: (context, state) {
        return unprotectedRouteRedirect(context, "/groups");
      },
    ),
    GoRoute(
      path: '/groups',
      builder: (context, state) => const GroupSelect(),
      redirect: (context, state) {
        return protectedRouteRedirect(context, "/groups");
      },
    ),
    GoRoute(
      path: '/groups/:groupId',
      builder: (context, state) => const GroupHome(),
      redirect: (context, state) {
        return protectedRouteRedirect(context, "/groups/:groupId");
      },
    ),
  ],
);

class ReceiptWrangler extends StatefulWidget {
  const ReceiptWrangler({super.key});

  @override
  State<ReceiptWrangler> createState() => _ReceiptWrangler();
}

class _ReceiptWrangler extends State<ReceiptWrangler> {
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();

    _lifecycleListener = AppLifecycleListener(onStateChange: _onStateChanged);
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authModel = Provider.of<AuthModel>(context, listen: false);
    authModel.initializeAuth();

    return MaterialApp.router(
      title: 'Receipt Wrangler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }

  // Listen to the app lifecycle state changes
  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        _onDetached();
      case AppLifecycleState.resumed:
        _onResumed();
      case AppLifecycleState.inactive:
        _onInactive();
      case AppLifecycleState.hidden:
        _onHidden();
      case AppLifecycleState.paused:
        _onPaused();
    }
  }

  void _onDetached() => print('detached');

  void _onResumed() async {
    // TODO: check connection to server
    print("resumed");
    var authModel = Provider.of<AuthModel>(context, listen: false);
    var groupModel = Provider.of<GroupModel>(context, listen: false);
    var userModel = Provider.of<UserModel>(context, listen: false);
    var userPreferencesModel =
        Provider.of<UserPreferencesModel>(context, listen: false);

    await refreshTokens(authModel, groupModel, userModel, userPreferencesModel);
  }

  void _onInactive() => print('inactive');

  void _onHidden() => print('hidden');

  void _onPaused() => print('paused');
}
