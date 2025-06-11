import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as api;
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
import 'package:receipt_wrangler_mobile/models/custom_field_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/models/loading_model.dart';
import 'package:receipt_wrangler_mobile/models/receipt-list-model.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/models/search_model.dart';
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
import 'package:receipt_wrangler_mobile/search/nav/search_app_bar.dart';
import 'package:receipt_wrangler_mobile/search/screens/search_screen.dart';
import 'package:receipt_wrangler_mobile/search/widgets/searchbar.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/circular_loading_progress.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/utils/auth.dart';
import 'package:receipt_wrangler_mobile/utils/permissions.dart';
import 'package:receipt_wrangler_mobile/utils/snackbar.dart';

import 'client/client.dart';
import 'constants/colors.dart';
import 'constants/font.dart' as typography;
import 'constants/search.dart';
import 'constants/theme.dart';
import 'models/context_model.dart';
import 'models/system_settings_model.dart';

void main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GlobalSharedPreferences.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthModel()),
      ChangeNotifierProvider(create: (_) => CategoryModel()),
      ChangeNotifierProvider(create: (_) => ContextModel()),
      ChangeNotifierProvider(create: (_) => CustomFieldModel()),
      ChangeNotifierProvider(create: (_) => GroupModel()),
      ChangeNotifierProvider(create: (_) => LoadingModel()),
      ChangeNotifierProvider(create: (_) => ReceiptListModel()),
      ChangeNotifierProvider(create: (_) => ReceiptModel()),
      ChangeNotifierProvider(create: (_) => SearchModel()),
      ChangeNotifierProvider(create: (_) => SystemSettingsModel()),
      ChangeNotifierProvider(create: (_) => TagModel()),
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
          var fullPath = state.fullPath!;
          if (fullPath.contains("images")) {
            padding = const EdgeInsets.all(0);
          }

          var contextModel = Provider.of<ContextModel>(context, listen: false);
          var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
          var actionBuilder = ReceiptAppBarActionBuilder(context, receiptModel);
          var bottomSheetBuilder =
              ReceiptBottomSheetBuilder(context, receiptModel);
          var customFieldModel =
              Provider.of<CustomFieldModel>(context, listen: false);

          if (!customFieldModel.isLoading) {
            customFieldModel.loadCustomFields();
          }

          Future<Response<api.Receipt?>> future = Future.value(
              Response<api.Receipt?>(
                  data: null, requestOptions: RequestOptions()));

          var receiptId = state.pathParameters['receiptId'] ?? "0";
          var idsAreDifferent = receiptId != receiptModel.receipt.id.toString();

          if (idsAreDifferent && receiptId.isNotEmpty) {
            future = OpenApiClient.client.getReceiptApi().getReceiptById(
                receiptId:
                    int.parse(state.pathParameters['receiptId'] as String));
          }

          contextModel.setShellContext(context);

          return FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                var isReady =
                    snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData;

                if (isReady && idsAreDifferent) {
                  receiptModel.setReceipt(
                      snapshot.data?.data as api.Receipt, false);
                }

                if (snapshot.hasError) {
                  Future.microtask(() =>
                      showErrorSnackbar(context, "Receipt not available"));
                  context.go('/');
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
              path: '/receipts/images/add',
              builder: (context, state) => const ReceiptImageScreen()),
          GoRoute(
              path: '/receipts/:receiptId/images/view',
              builder: (context, state) => const ReceiptImageScreen()),
          GoRoute(
              path: '/receipts/:receiptId/images/edit',
              builder: (context, state) => const ReceiptImageScreen()),
          GoRoute(
              path: '/receipts/comments/add',
              builder: (context, state) => const ReceiptCommentScreen()),
          GoRoute(
              path: '/receipts/:receiptId/comments/view',
              builder: (context, state) => const ReceiptCommentScreen()),
          GoRoute(
            path: '/receipts/:receiptId/comments/edit',
            builder: (context, state) => const ReceiptCommentScreen(),
          ),
          GoRoute(
            path: '/receipts/add',
            builder: (context, state) => const ReceiptFormScreen(),
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
    ShellRoute(
      builder: (context, state, child) {
        var searchModel = Provider.of<SearchModel>(context, listen: false);
        searchModel.searchTermBehaviorSubject.add("");
        searchModel.setSearchResults([], notify: false);

        var extra = state.extra as Map<String, dynamic>;
        var from = extra["from"];

        return ScreenWrapper(
          appBarWidget: SearchAppBar(),
          bodyPadding: const EdgeInsets.all(0),
          bottomNavigationBarWidget: from == fromGroupBottomNav
              ? const GroupBottomNav()
              : const GroupSelectBottomNav(),
          child: child,
          bottomSheetWidget: const WranglerSearchBar(),
        );
      },
      routes: [
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
      ],
    )
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
  late final systemSettingsModel =
      Provider.of<SystemSettingsModel>(context, listen: false);
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
          userPreferencesModel, categoryModel, tagModel, systemSettingsModel,
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
        useMaterial3: true,

        // Color Scheme
        colorScheme: const ColorScheme(
          primary: primaryBlue,
          secondary: secondaryGrayBlue,
          surface: surfaceColor,
          error: errorRed,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: gray900,
          onError: Colors.white,
          brightness: Brightness.light,
          surfaceTint: primaryBlue,
        ),

        // Typography Theme
        textTheme: const TextTheme(
          displayLarge: typography.displayLarge,
          displayMedium: typography.displayMedium,
          headlineLarge: typography.headlineLarge,
          headlineMedium: typography.headlineMedium,
          titleLarge: typography.titleLarge,
          titleMedium: typography.titleMedium,
          bodyLarge: typography.bodyLarge,
          bodyMedium: typography.bodyMedium,
          bodySmall: typography.bodySmall,
          labelLarge: typography.labelLarge,
          labelMedium: typography.labelMedium,
          labelSmall: typography.labelSmall,
        ),

        // Input Decoration Theme
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: gray50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
            borderSide: BorderSide(color: gray300, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
            borderSide: BorderSide(color: gray300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
            borderSide: BorderSide(color: primaryBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
            borderSide: BorderSide(color: errorRed, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
            borderSide: BorderSide(color: errorRed, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),

        // Card Theme
        cardTheme: const CardTheme(
          elevation: elevationLow,
          shape: cardShape,
          color: cardColor,
          shadowColor: shadowMedium,
          surfaceTintColor: Colors.transparent,
        ),

        // App Bar Theme
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: elevationLow,
          backgroundColor: surfaceColor,
          foregroundColor: gray900,
          titleTextStyle: typography.titleLarge,
          surfaceTintColor: Colors.transparent,
        ),

        // Bottom Navigation Theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: surfaceColor,
          selectedItemColor: primaryBlue,
          unselectedItemColor: gray500,
          elevation: elevationMedium,
          type: BottomNavigationBarType.fixed,
        ),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: elevationLow,
            shape: buttonShape,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            textStyle: typography.labelLarge,
          ),
        ),

        // Outlined Button Theme
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: buttonShape,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            side: const BorderSide(color: primaryBlue, width: 1),
            foregroundColor: primaryBlue,
            textStyle: typography.labelLarge,
          ),
        ),

        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: buttonShape,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            foregroundColor: primaryBlue,
            textStyle: typography.labelLarge,
          ),
        ),

        // Chip Theme
        chipTheme: ChipThemeData(
          shape: chipShape,
          backgroundColor: gray100,
          selectedColor: Color.fromRGBO(39, 177, 255, 0.12),
          labelStyle: typography.labelMedium,
          elevation: 0,
          pressElevation: elevationLow,
        ),

        // Bottom Sheet Theme
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: surfaceColor,
          modalBackgroundColor: surfaceColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadiusLarge),
            ),
          ),
          elevation: elevationHigh,
        ),

        // Dialog Theme
        dialogTheme: const DialogTheme(
          backgroundColor: surfaceColor,
          surfaceTintColor: Colors.transparent,
          shape: dialogShape,
          elevation: elevationMax,
        ),

        // Floating Action Button Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: elevationMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadiusLarge)),
          ),
        ),

        // List Tile Theme
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          titleTextStyle: typography.bodyLarge,
          subtitleTextStyle: typography.bodyMedium,
        ),

        // Divider Theme
        dividerTheme: const DividerThemeData(
          color: gray200,
          thickness: 1,
          space: 1,
        ),
      ),
      routerConfig: _router,
    );
  }

  @override
  Widget build(BuildContext context) {
    authModel.initializeAuth();
    var future = refreshTokens(authModel, groupModel, userModel,
        userPreferencesModel, categoryModel, tagModel, systemSettingsModel);

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
        categoryModel, tagModel, systemSettingsModel);
  }

  void _onInactive() => print('inactive');

  void _onHidden() => print('hidden');

  void _onPaused() => print('paused');
}
