import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:igenius/Features/Account/presentation/views/pages/about_us_screen.dart';
import 'package:igenius/Features/Account/presentation/views/pages/edit_profile_screen.dart';
import 'package:igenius/Features/Account/presentation/views/pages/my_courses_screen.dart';
import 'package:igenius/Features/Account/presentation/views/pages/privacy_policy_screen.dart';
import 'package:igenius/Features/Auth/presentation/views/pages/create_account.dart';
import 'package:igenius/Features/Auth/presentation/views/pages/forget_password_screen.dart';
import 'package:igenius/Features/Auth/presentation/views/pages/login_screen.dart';
import 'package:igenius/Features/Courses/presentation/cubits/lessons/lesson_content_cubit.dart';
import 'package:igenius/Features/Courses/presentation/views/pages/assignment_screen.dart';
import 'package:igenius/Features/Courses/presentation/views/pages/video_player_screen.dart';
import 'package:igenius/Features/home/presentation/views/pages/Home_screen.dart';
import 'package:igenius/Features/layout/layout_screen.dart';
import 'package:igenius/Features/payment/presentation/cubits/buy_lesson_cubit.dart';
import 'package:igenius/Features/payment/presentation/cubits/pay_installment_cubit.dart';
import 'package:igenius/Features/payment/presentation/cubits/request_installment_plan_cubit.dart';
import 'package:igenius/splash_screen.dart';
import '../../Features/Account/presentation/cubits/profile/profile_cubit.dart';
import '../../Features/Account/presentation/cubits/profile/update_profile_cubit.dart';
import '../../Features/Account/presentation/cubits/reports/download_report_cubit.dart';
import '../../Features/Account/presentation/cubits/schedule/get_overdues_cubit.dart';
import '../../Features/Account/presentation/cubits/schedule/get_upcomings_cubit.dart';
import '../../Features/Account/presentation/cubits/support/my_support_tickets_cubit.dart';
import '../../Features/Account/presentation/cubits/support/send_support_ticket.dart';
import '../../Features/Account/presentation/views/pages/help_and_support_screen.dart';
import '../../Features/Account/presentation/views/pages/my_installements_screen.dart';
import '../../Features/Account/presentation/views/pages/my_tickets_screen.dart';
import '../../Features/Account/presentation/views/pages/overdues_page.dart';
import '../../Features/Account/presentation/views/pages/reports_download_page.dart';
import '../../Features/Account/presentation/views/pages/upcomings_page.dart';
import '../../Features/Auth/presentation/cubits/auth_cubit.dart';
import '../../Features/Auth/presentation/cubits/password_cubit.dart';
import '../../Features/Auth/presentation/views/pages/new_password_screen.dart';
import '../../Features/Auth/presentation/views/pages/otp_screen.dart';
import '../../Features/Courses/data/models/teacher.dart';
import '../../Features/Courses/presentation/cubits/courses/course_details_cubit.dart';
import '../../Features/Courses/presentation/cubits/courses/courses_by_teacher_cubit.dart';
import '../../Features/Courses/presentation/cubits/courses/courses_cubit.dart';
import '../../Features/Courses/presentation/cubits/courses/home_courses_cubit.dart';
import '../../Features/Courses/presentation/cubits/lessons/mark_attendance_cubit.dart';
import '../../Features/Courses/presentation/cubits/my_courses/my_course_details_cubit.dart';
import '../../Features/Courses/presentation/cubits/my_courses/my_courses_cubit.dart';
import '../../Features/Courses/presentation/views/pages/course_details_screen.dart';
import '../../Features/Courses/presentation/views/pages/courses_screen.dart';
import '../../Features/Courses/presentation/views/pages/payment_screen.dart';
import '../../Features/Home/presentation/cubits/get_about_cubit.dart';
import '../../Features/Home/presentation/cubits/get_home_data_cubit.dart';
import '../../Features/Notifications/presentation/cubits/delete_notification_cubit.dart';
import '../../Features/Notifications/presentation/cubits/mark_as_read_cubit.dart';
import '../../Features/Notifications/presentation/cubits/notifications_cubit.dart';
import '../../Features/Teachers/data/models/teacher_model.dart';
import '../../Features/Teachers/presentation/cubits/get_teacher_details_cubit.dart';
import '../../Features/Teachers/presentation/cubits/get_teachers_cubit.dart';
import '../../Features/filters/presentation/cubits/filter_data_cubit.dart';
import '../../Features/filters/presentation/pages/filters_screen.dart';
import '../../Features/Courses/presentation/views/pages/lesson_view_screen.dart';
import '../../Features/Notifications/presentation/views/pages/notifications_screen.dart';
import '../../Features/Teachers/presentation/views/pages/teachers_screen.dart';
import '../../Features/Teachers/presentation/views/widgets/teacher_profile.dart';
import '../../Features/payment/presentation/cubits/buy_course_cubit.dart';
import '../../Features/payment/presentation/cubits/get_installments_cubit.dart';
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
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: LoginScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => CreateAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<PasswordCubit>(),
              child: ForgetPasswordScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.layout,
        builder: (context, state) {
          Map<String, dynamic> args = state.extra! as Map<String, dynamic>;
          final isGuest = args['isGuest'] as bool;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<CoursesCubit>()),
              BlocProvider(create: (context) => sl<GetTeachersCubit>()),
              BlocProvider(create: (context) => sl<ProfileCubit>()),
              BlocProvider(create: (context) => sl<GetHomeDataCubit>()),
              BlocProvider(create: (context) => sl<GetNotificationsCubit>()),
              BlocProvider(create: (context) => sl<DownloadReportCubit>()),
            ],
            child: LayoutScreen(isGuest: isGuest, key: layoutKey),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.filtersScreen,
        pageBuilder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final isCourses = args['isCourses'] as bool;
          return SlideFadeTransition(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: sl<FilterDataCubit>()),
                BlocProvider(create: (context) => sl<CoursesCubit>()),
              ],
              child: FiltersScreen(isCourses: isCourses),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.teacherProfile,
        pageBuilder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final teacherId = args['teacherId'] as int;
          return SlideFadeTransition(
            child: BlocProvider(
              create: (context) => sl<GetTeacherDetailsCubit>(),
              child: TeacherProfile(teacherId: teacherId),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.videoPlayerScreen,
        pageBuilder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return SlideFadeTransition(
            child: CustomVideoPlayer(
              onProgressThresholdReached:
                  args['onProgressThresholdReached'] as VoidCallback,
              videoUrl: args['videoUrl'] as String,
              autoPlay: true,
              looping: true,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.courseDetails,
        pageBuilder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final courseId = args['courseId'] as int;
          final isBought = args['isBought'] as bool;
          return SlideFadeTransition(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => sl<CourseDetailsCubit>()),
                BlocProvider(create: (context) => sl<MyCourseDetailsCubit>()),
              ],
              child: CourseDetailsScreen(
                isBought: isBought,
                courseId: courseId,
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.paymentWebViewScreen,
        pageBuilder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final paymentUrl = args['paymentUrl'] as String;
          return SlideFadeTransition(
            child: PaymentWebViewScreen(paymentUrl: paymentUrl),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.notificationsScreen,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => sl<GetNotificationsCubit>()),
                BlocProvider(
                  create: (context) => sl<MarkNotificationAsReadCubit>(),
                ),
                BlocProvider(
                  create: (context) => sl<DeleteNotificationCubit>(),
                ),
              ],
              child: NotificationsScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.lessonViewScreen,
        pageBuilder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final lessonId = args['lessonId'] as int;
          final unitTitle = args['unitTitle'] as String;
          final isOwned = args['isOwned'] as bool;
          return SlideFadeTransition(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => sl<LessonContentCubit>()),
                BlocProvider(create: (context) => sl<MarkAttendanceCubit>()),
              ],
              child: LessonViewScreen(
                unitTitle: unitTitle,
                lessonId: lessonId,
                isOwned: isOwned,
              ),
            ),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.assignmentViewScreen,
        pageBuilder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final id = args['id'] as int;
          final unitTitle = args['unitTitle'] as String;
          final isExam = args['isExam'] as bool;
          return SlideFadeTransition(
            child: AssignmentScreen(
              isExam: isExam,
              id: id,
              unitTitle: unitTitle,
            ),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.aboutUsScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<GetAboutCubit>()..getAbout(),
              child: AboutUsScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.editProfileScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<UpdateProfileCubit>(),
              child: EditProfileScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.myCoursesScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<MyCoursesCubit>(),
              child: MyCoursesScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.myInstallmentsScreen,
        builder:
            (context, state) => InstallmentsPage(),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicyScreen,
        builder: (context, state) => PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: AppRoutes.sendSuppotTicketScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<SendSupportTicket>(),
              child: HelpAndSupportScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.otpScreen,
        builder: (context, state) => OtpScreen(),
      ),
      GoRoute(
        path: AppRoutes.createNewPassword,
        builder: (context, state) => NewPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.downloadReportScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<DownloadReportCubit>(),
              child: ReportsDownloadPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.overduesScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<GetOverduesCubit>(),
              child: OverduePage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.upcomingsScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<GetUpcomingsCubit>(),
              child: UpcomingPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.myTicketsScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<MySupportTicketsCubit>(),
              child: MySupportTicketsScreen(),
            ),
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
