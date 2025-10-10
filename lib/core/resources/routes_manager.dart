
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:igenius/Features/home/presentation/views/pages/Home_screen.dart';
import '../../injection/service_locator.dart';
import '../constants/app_routes.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class RoutesManager {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.inital,
    observers: [routeObserver],
        navigatorKey: sl<GlobalKey<NavigatorState>>(),
    routes: [
      GoRoute(
        path: AppRoutes.inital,
        builder: (context, state) =>  HomeScreen(),
        // HelperMethods.initalScreen(),
      ),


      // GoRoute(
      //   path: AppRoutes.orderInfo,
      //   pageBuilder: (context, state) {
      //     final data = state.extra as Map<String, dynamic>;
      //     final order = data["order"] as OrderModel;
      //     final fromMakingOrder = data["fromMakingOrder"] as bool?;
      //     return ScaleTransitionPage(
      //       child: OrderInfoScreen(
      //           orderParams: order, fromMakingOrder: fromMakingOrder),
      //     );
      //   },
      // ),
    
    ],
  );
}
