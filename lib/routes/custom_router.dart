import 'package:flutter/material.dart';
import 'package:flutter_exercise/ui/bottom_navigation/contact/contact_page.dart';
import 'package:go_router/go_router.dart';
import '../models/account_model.dart';
import '../ui/bottom_navigation/account/account_page.dart';
import '../ui/bottom_navigation/bottom_navigation_page.dart';
import '../ui/bottom_navigation/home/home_page.dart';
import '../ui/bottom_navigation/service/service_page.dart';
import '../ui/bottom_navigation/statement/statement_page.dart';
import '../ui/bottom_navigation/transaction/transaction_page.dart';
import '../ui/login/login_screen.dart';

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
      CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> accountTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> serviceTabNavigatorKey =
      GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static const String logInPath = '/logIn';
  static const String homePath = '/home';
  static const String accountPath = '/account';
  static const String servicePath = '/search';

  static const String transaction = '/transaction';
  static const String statement = '/statement';
  static const String contact = '/contact';

  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: homePath,
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const HomePage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: accountTabNavigatorKey,
            routes: [
              GoRoute(
                parentNavigatorKey: accountTabNavigatorKey,
                path: accountPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const AccountPage(),
                    state: state,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: accountTabNavigatorKey,
                path: transaction,
                pageBuilder: (context, state) {
                  return getPage(
                    child: TransactionPage(account: state.extra as Accounts),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: serviceTabNavigatorKey,
            routes: [
              GoRoute(
                path: servicePath,
                parentNavigatorKey: serviceTabNavigatorKey,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const ServicePage(),
                    state: state,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: serviceTabNavigatorKey,
                path: contact,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const ContactScreen(),
                    state: state,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: serviceTabNavigatorKey,
                path: statement,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const StatementPage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
        ],
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return getPage(
            child: BottomNavigationPage(
              child: navigationShell,
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: logInPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const LoginScreen(),
            state: state,
          );
        },
      ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: logInPath,
      routes: routes,
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
