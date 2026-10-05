import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../injection/service_locator.dart';
import '../../constants/app_routes.dart';

class AppNavaigation {
  static final GlobalKey<NavigatorState> navigatorKey =
      sl<GlobalKey<NavigatorState>>();

  static BuildContext get context => navigatorKey.currentContext!;

  // GoRouter navigation
  static void goToPage(String page) => context.go(page);
  static void replacePage(String page) => context.pushReplacement(page);

  static void goToPageWithParams(String page, Map<String, dynamic> params) =>
      context.go(page, extra: params);

  static void push(String routeName) => context.push(routeName);

  static void pushToPageWithParams(String page, Map<String, dynamic> params) =>
      context.push(page, extra: params);
  static Future<bool?> pushandReturnValueToPageWithParams(
    String page,
    Map<String, dynamic> params,
  ) => context.push<bool>(page, extra: params);
  static void pop() => context.pop();

  // Predefined routes
  static void goToLogin() => goToPage(AppRoutes.login);
  static void goToSignUp() => push(AppRoutes.register);
  static void goToHome({bool isGuest = false}) =>
      goToPageWithParams(AppRoutes.layout, {'isGuest': isGuest});

  static void replacePageWithParams(String page, Map<String, dynamic> params) =>
      context.pushReplacement(page, extra: params);
}
