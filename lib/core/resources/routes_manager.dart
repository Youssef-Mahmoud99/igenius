import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:igenius/Features/Auth/presentation/views/pages/create_account.dart';
import 'package:igenius/Features/Auth/presentation/views/pages/login_screen.dart';
import 'package:igenius/Features/home/presentation/views/pages/Home_screen.dart';
import 'package:igenius/Features/layout/layout_screen.dart';
import 'package:igenius/splash_screen.dart';
import '../../Features/Courses/presentation/views/pages/course_details_screen.dart';
import '../../Features/Courses/presentation/views/pages/courses_screen.dart';
import '../../Features/Courses/presentation/views/pages/filters_screen.dart';
import '../../Features/Notifications/presentation/views/pages/notifications_screen.dart';
import '../../Features/Teachers/presentation/views/pages/teachers_screen.dart';
import '../../Features/Teachers/presentation/views/widgets/teacher_profile.dart';
import '../../app.dart';
import '../../injection/service_locator.dart';
import '../animations/page_transitions.dart';
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
        builder: (context, state) => SplashScreen(),
        // HelperMethods.initalScreen(),
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => CreateAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.layout,
        builder: (context, state) {
          Map<String, dynamic> args = state.extra! as Map<String, dynamic>;
          final isGuest = args['isGuest'] as bool;
          return LayoutScreen(isGuest: isGuest, key: layoutKey);
        },
      ),
      GoRoute(
        path: AppRoutes.filtersScreen,
        pageBuilder: (context, state) {
          return SlideFadeTransition(child: FiltersScreen());
        },
      ),
      GoRoute(
        path: AppRoutes.teacherProfile,
        builder: (context, state) => TeacherProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.courseDetails,
        builder: (context, state) => CourseDetailsScreen(),
      ),

      GoRoute(
        path: AppRoutes.notificationsScreen,
        builder: (context, state) => NotificationsScreen(),
      ),

      // GoRoute(

      //   path: AppRoutes.inital,
      //   builder: (context, state) =>  HomeScreen(),
      //   // HelperMethods.initalScreen(),
      // ),
      // GoRoute(

      //   path: AppRoutes.inital,
      //   builder: (context, state) =>  HomeScreen(),
      //   // HelperMethods.initalScreen(),
      // ),

      //     GoRoute(
      //       path: AppRoutes.orderInfo,
      //       pageBuilder: (context, state) {
      //         final data = state.extra as Map<String, dynamic>;
      //         final order = data["order"] as OrderModel;
      //         final fromMakingOrder = data["fromMakingOrder"] as bool?;
      //         return ScaleTransitionPage(
      //           child: OrderInfoScreen(
      //               orderParams: order, fromMakingOrder: fromMakingOrder),
      //         );
      //       },
      //     ),
    ],
  );
}
