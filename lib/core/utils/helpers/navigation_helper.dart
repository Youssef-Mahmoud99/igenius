import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../injection/service_locator.dart';
import '../../constants/app_routes.dart';

class NavigationHelper {
  // GlobalKey مسجلة في service locator
  static final GlobalKey<NavigatorState> navigatorKey = sl<GlobalKey<NavigatorState>>();

  static BuildContext get context => navigatorKey.currentContext!;

  // GoRouter navigation
  static void goToPage(String page) => context.go(page);

  static void goToPageWithParams(String page, Map<String, dynamic> params) =>
      context.go(page, extra: params);

  static void push(String routeName) => context.push(routeName);

  static void pushToPageWithParams(String page, Map<String, dynamic> params) =>
      context.push(page, extra: params);

  static void pop() => context.pop();

  // Predefined routes
  static void goToLogin() => goToPage(AppRoutes.login);
  static void goToSignUp() => goToPage(AppRoutes.register);
  static void goToHome() => goToPage(AppRoutes.layout);
}
