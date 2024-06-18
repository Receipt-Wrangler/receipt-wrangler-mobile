import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/auth/login/screens/auth_screen.dart';
import 'package:receipt_wrangler_mobile/groups/nav/group/group_app_bar.dart';
import 'package:receipt_wrangler_mobile/groups/nav/group/group_bottom_nav.dart';
import 'package:receipt_wrangler_mobile/groups/nav/group_select/group_select_app_bar.dart';
import 'package:receipt_wrangler_mobile/groups/nav/group_select/group_select_bottom_nav.dart';
import 'package:receipt_wrangler_mobile/groups/screens/group_dashboards.dart';
import 'package:receipt_wrangler_mobile/groups/screens/group_receipts_screen.dart';
import 'package:receipt_wrangler_mobile/groups/screens/group_select.dart';
import 'package:receipt_wrangler_mobile/guards/auth-guard.dart';
import 'package:receipt_wrangler_mobile/home/screens/home.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/models/category_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/loading_model.dart';
import 'package:receipt_wrangler_mobile/models/receipt-list-model.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/models/tag_model.dart';
import 'package:receipt_wrangler_mobile/models/user_model.dart';
import 'package:receipt_wrangler_mobile/models/user_preferences_model.dart';
import 'package:receipt_wrangler_mobile/persistence/global_shared_preferences.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_app_bar.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_app_bar_action_builder.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_bottom_nav.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipt_bottom_sheet_builder.dart';
import 'package:receipt_wrangler_mobile/receipts/screens/receipt_comment_screen.dart';
import 'package:receipt_wrangler_mobile/receipts/screens/receipt_form_screen.dart';
import 'package:receipt_wrangler_mobile/receipts/screens/receipt_image_screen.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/circular_loading_progress.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/utils/auth.dart';
import 'package:receipt_wrangler_mobile/utils/permissions.dart';

import 'api.dart' as api;
import 'models/context_model.dart';

void main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GlobalSharedPreferences.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthModel()),
      ChangeNotifierProvider(create: (_) => CategoryModel()),
      ChangeNotifierProvider(create: (_) => GroupModel()),
      ChangeNotifierProvider(create: (_) => LoadingModel()),
      ChangeNotifierProvider(create: (_) => ReceiptListModel()),
      ChangeNotifierProvider(create: (_) => ReceiptModel()),
      ChangeNotifierProvider(create: (_) => TagModel()),
      ChangeNotifierProvider(create: (_) => UserModel()),
      ChangeNotifierProvider(create: (_) => UserPreferencesModel()),
      ChangeNotifierProvider(create: (_) => ContextModel()),
    ],
    child: const ReceiptWrangler(),
  ));
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ScreenWrapper(child: Home()),
      redirect: (context, state) {
        return unprotectedRouteRedirect(context, "/groups");
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const ScreenWrapper(child: AuthScreen()),
      redirect: (context, state) {
        return unprotectedRouteRedirect(context, "/groups");
      },
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const ScreenWrapper(child: AuthScreen()),
      redirect: (context, state) {
        return unprotectedRouteRedirect(context, "/groups");
      },
    ),
    ShellRoute(
        builder: (context, state, child) {
          return ScreenWrapper(
            appBarWidget: const GroupSelectAppBar(),
            bottomNavigationBarWidget: const GroupSelectBottomNav(),
            child: child,
          );
        },
        routes: [
          GoRoute(
              path: "/groups",
              builder: (context, state) => const GroupSelect()),
        ]),
    ShellRoute(
        builder: (context, state, child) {
          EdgeInsets? padding;
          if (state.fullPath == '/groups/:groupId/receipts') {
            padding = const EdgeInsets.all(0);
          }
          return ScreenWrapper(
            appBarWidget: const GroupAppBar(),
            bottomNavigationBarWidget: const GroupBottomNav(),
            bodyPadding: padding,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/groups/:groupId/dashboards',
            builder: (context, state) => const GroupDashboards(),
          ),
          GoRoute(
            path: '/groups/:groupId/receipts',
            builder: (context, state) => const GroupReceiptsScreen(),
          ),
        ]),
    ShellRoute(
        builder: (context, state, child) {
          EdgeInsets? padding;
          if (state.fullPath!.contains("images")) {
            padding = const EdgeInsets.all(0);
          }

          var contextModel = Provider.of<ContextModel>(context, listen: false);
          var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
          var actionBuilder = ReceiptAppBarActionBuilder(context, receiptModel);
          var bottomSheetBuilder =
              ReceiptBottomSheetBuilder(context, receiptModel);
          var future = api.ReceiptApi().getReceiptById(
              int.parse(state.pathParameters['receiptId'] as String));

          contextModel.setShellContext(context);

          return FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                var isReady =
                    snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData;

                if (isReady) {
                  receiptModel.setReceipt(snapshot.data as api.Receipt, false);
                }

                return ScreenWrapper(
                  appBarWidget: ReceiptAppBar(
                      actions: actionBuilder.buildAppBarMenu(state)),
                  bottomNavigationBarWidget: const ReceiptBottomNav(),
                  bodyPadding: padding,
                  bottomSheetWidget: bottomSheetBuilder.buildBottomSheet(state),
                  child: isReady ? child : const CircularLoadingProgress(),
                );
              });
        },
        routes: [
          GoRoute(
              path: '/receipts/:receiptId/images/view',
              builder: (context, state) => const ReceiptImageScreen()),
          GoRoute(
              path: '/receipts/:receiptId/images/edit',
              builder: (context, state) => const ReceiptImageScreen()),
          GoRoute(
              path: '/receipts/:receiptId/comments/view',
              builder: (context, state) => const ReceiptCommentScreen()),
          GoRoute(
            path: '/receipts/:receiptId/comments/edit',
            builder: (context, state) => const ReceiptCommentScreen(),
          ),
          GoRoute(
            path: '/receipts/:receiptId/view',
            builder: (context, state) => const ReceiptFormScreen(),
          ),
          GoRoute(
            path: '/receipts/:receiptId/edit',
            builder: (context, state) => const ReceiptFormScreen(),
          ),
        ]),
  ],
);

class ReceiptWrangler extends StatefulWidget {
  const ReceiptWrangler({super.key});

  @override
  State<ReceiptWrangler> createState() => _ReceiptWrangler();
}

class _ReceiptWrangler extends State<ReceiptWrangler> {
  late final AppLifecycleListener _lifecycleListener;
  late final authModel = Provider.of<AuthModel>(context, listen: false);
  late final groupModel = Provider.of<GroupModel>(context, listen: false);
  late final userModel = Provider.of<UserModel>(context, listen: false);
  late final categoryModel = Provider.of<CategoryModel>(context, listen: false);
  late final tagModel = Provider.of<TagModel>(context, listen: false);
  late final userPreferencesModel =
      Provider.of<UserPreferencesModel>(context, listen: false);

  @override
  void initState() {
    super.initState();

    _lifecycleListener = AppLifecycleListener(onStateChange: _onStateChanged);

    requestPermissions();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Timer.periodic(const Duration(minutes: 15), (timer) async {
      await refreshTokens(authModel, groupModel, userModel,
          userPreferencesModel, categoryModel, tagModel,
          force: true);
    });
  }

  Widget _buildRouter() {
    return MaterialApp.router(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: 'Receipt Wrangler',
      theme: ThemeData(
        fontFamily: "Raleway",
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          modalBackgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        colorScheme: const ColorScheme(
          primary: Color(0xFF27B1FF),
          secondary: Color(0xFF8EA1AC),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFFFFFFF),
          error: Color(0xFFd63333),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF000000),
          onSurface: Color(0xFF000000),
          onBackground: Color(0xFF000000),
          onError: Color(0xFFFFFFFF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }

  @override
  Widget build(BuildContext context) {
    authModel.initializeAuth();
    var future = refreshTokens(authModel, groupModel, userModel,
        userPreferencesModel, categoryModel, tagModel);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildRouter();
        }

        return const CircularLoadingProgress();
      },
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
    print("resumed");
    await refreshTokens(authModel, groupModel, userModel, userPreferencesModel,
        categoryModel, tagModel);
  }

  void _onInactive() => print('inactive');

  void _onHidden() => print('hidden');

  void _onPaused() => print('paused');
}
