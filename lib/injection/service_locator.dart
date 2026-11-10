import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:igenius/Features/Account/data/repos/profile/profile_repo.dart';
import 'package:igenius/Features/Auth/presentation/cubits/auth_cubit.dart';

import '../Features/Account/data/network/profile/profile_api.dart';
import '../Features/Account/data/network/reports/reports_api.dart';
import '../Features/Account/data/network/schedule/schedule_api.dart';
import '../Features/Account/data/network/support/support_api.dart';
import '../Features/Account/data/repos/profile/profile_repo_impl.dart';
import '../Features/Account/data/repos/reports/reports_repo.dart';
import '../Features/Account/data/repos/reports/reports_repo_impl.dart';
import '../Features/Account/data/repos/schedule/schedule_repo.dart';
import '../Features/Account/data/repos/schedule/schedule_repo_impl.dart';
import '../Features/Account/data/repos/support/support_repo.dart';
import '../Features/Account/data/repos/support/support_repo_impl.dart';
import '../Features/Account/presentation/cubits/profile/profile_cubit.dart';
import '../Features/Account/presentation/cubits/profile/update_profile_cubit.dart';
import '../Features/Account/presentation/cubits/reports/download_report_cubit.dart';
import '../Features/Account/presentation/cubits/schedule/get_overdues_cubit.dart';
import '../Features/Account/presentation/cubits/schedule/get_upcomings_cubit.dart';
import '../Features/Account/presentation/cubits/support/my_support_tickets_cubit.dart';
import '../Features/Account/presentation/cubits/support/send_support_ticket.dart';
import '../Features/Auth/data/network/auth_api.dart';
import '../Features/Auth/data/network/password_api.dart';
import '../Features/Auth/data/repos/auth_repo.dart';
import '../Features/Auth/data/repos/auth_repo_impl.dart';
import '../Features/Auth/data/repos/password_repo.dart';
import '../Features/Auth/data/repos/password_repo_impl.dart';
import '../Features/Auth/presentation/cubits/password_cubit.dart';
import '../Features/Courses/data/network/courses_api.dart';
import '../Features/Courses/data/repos/courses_repo.dart';
import '../Features/Courses/data/repos/courses_repo_impl.dart';
import '../Features/Courses/presentation/cubits/assignments/assignment_attemps_cubit.dart';
import '../Features/Courses/presentation/cubits/assignments/assignment_details_cubit.dart';
import '../Features/Courses/presentation/cubits/assignments/get_assignments_cubit.dart';
import '../Features/Courses/presentation/cubits/assignments/submit_assinment.dart';
import '../Features/Courses/presentation/cubits/courses/course_details_cubit.dart';
import '../Features/Courses/presentation/cubits/courses/courses_by_teacher_cubit.dart';
import '../Features/Courses/presentation/cubits/courses/courses_cubit.dart';
import '../Features/Courses/presentation/cubits/courses/home_courses_cubit.dart';
import '../Features/Courses/presentation/cubits/exams/exam_attemps_cubit.dart';
import '../Features/Courses/presentation/cubits/exams/exam_details_cubit.dart';
import '../Features/Courses/presentation/cubits/exams/exams_cubit.dart';
import '../Features/Courses/presentation/cubits/exams/submit_exam.dart';
import '../Features/Courses/presentation/cubits/lessons/lesson_content_cubit.dart';
import '../Features/Courses/presentation/cubits/lessons/mark_attendance_cubit.dart';
import '../Features/Courses/presentation/cubits/my_courses/my_course_details_cubit.dart';
import '../Features/Courses/presentation/cubits/my_courses/my_courses_cubit.dart';
import '../Features/Home/data/network/home_api.dart';
import '../Features/Home/data/repos/Home_repo_impl.dart';
import '../Features/Home/data/repos/home_repo.dart';
import '../Features/Home/presentation/cubits/get_about_cubit.dart';
import '../Features/Home/presentation/cubits/get_home_data_cubit.dart';
import '../Features/Notifications/data/network/notifications_api.dart';
import '../Features/Notifications/data/repos/notifications_repo.dart';
import '../Features/Notifications/data/repos/notifications_repo_impl.dart';
import '../Features/Notifications/presentation/cubits/delete_notification_cubit.dart';
import '../Features/Notifications/presentation/cubits/mark_as_read_cubit.dart';
import '../Features/Notifications/presentation/cubits/notifications_cubit.dart';
import '../Features/Teachers/data/network/teacher_api.dart';
import '../Features/Teachers/data/repos/teacher_repo.dart';
import '../Features/Teachers/data/repos/teacher_repo_impl.dart';
import '../Features/Teachers/presentation/cubits/get_teacher_details_cubit.dart';
import '../Features/Teachers/presentation/cubits/get_teachers_cubit.dart';
import '../Features/filters/data/network/filter_data_api.dart';
import '../Features/filters/data/repos/filter_data_repo.dart';
import '../Features/filters/data/repos/filter_data_repo_impl.dart';
import '../Features/filters/presentation/cubits/filter_data_cubit.dart';
import '../Features/payment/data/network/payment_api.dart';
import '../Features/payment/data/repos/payment_repo.dart';
import '../Features/payment/data/repos/payment_repo_impl.dart';
import '../Features/payment/presentation/cubits/buy_course_cubit.dart';
import '../Features/payment/presentation/cubits/buy_lesson_cubit.dart';
import '../Features/payment/presentation/cubits/get_installments_cubit.dart';
import '../Features/payment/presentation/cubits/get_payments_cubit.dart';
import '../Features/payment/presentation/cubits/pay_installment_cubit.dart';
import '../Features/payment/presentation/cubits/request_installment_plan_cubit.dart';
import '../Features/payment/presentation/cubits/request_two_month_installement.dart';
import '../core/network/dio_client.dart';
import '../core/network/network_info.dart';
import '../core/services/localization_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 👇 الأول دايماً
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  sl.registerLazySingleton<GetStorage>(() => GetStorage());

  // Network
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Dio Client — دلوقتي الـ FlutterSecureStorage موجود
  final dioClient = await DioClient.create();
  sl.registerLazySingleton<DioClient>(() => dioClient);

  // Navigation
  sl.registerLazySingleton<GlobalKey<NavigatorState>>(
    () => GlobalKey<NavigatorState>(),
  );

  // Localization
  sl.registerLazySingleton<LocalizationService>(() => LocalizationService());

  // Auth
  sl.registerLazySingleton<AuthApi>(() => AuthApi(sl<DioClient>().dio));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl<AuthApi>()));
  sl.registerFactory(() => AuthCubit(sl<AuthRepo>()));
  // Password
  sl.registerLazySingleton<PasswordApi>(() => PasswordApi(sl<DioClient>().dio));
  sl.registerLazySingleton<PasswordRepo>(
    () => PasswordRepoImpl(sl<PasswordApi>()),
  );
  sl.registerLazySingleton(() => PasswordCubit(sl<PasswordRepo>()));

  // Courses
  sl.registerLazySingleton<CoursesApi>(() => CoursesApi(sl<DioClient>().dio));
  sl.registerLazySingleton<CoursesRepo>(
    () => CoursesRepoImpl(sl<CoursesApi>()),
  );
  sl.registerLazySingleton(() => CoursesCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => CourseDetailsCubit(sl<CoursesRepo>()));

  // My Courses
  sl.registerFactory(() => MyCoursesCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => MyCourseDetailsCubit(sl<CoursesRepo>()));

  // Lessons
  sl.registerFactory(() => LessonContentCubit(sl<CoursesRepo>()));
  sl.registerLazySingleton(() => MarkAttendanceCubit(sl<CoursesRepo>()));

  // Assignments
  sl.registerLazySingleton(() => AssignmentsCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => AssignmentDetailsCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => AssignmentAttemptsCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => SubmitAssignmentCubit(sl<CoursesRepo>()));

  // Exams
  sl.registerLazySingleton(() => MyExamsCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => MyExamDetailsCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => ExamAttemptsCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => SubmitExamCubit(sl<CoursesRepo>()));

  // Profile
  sl.registerLazySingleton<ProfileApi>(() => ProfileApi(sl<DioClient>().dio));
  sl.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(sl<ProfileApi>()),
  );
  sl.registerFactory(() => ProfileCubit(sl<ProfileRepo>()));
  sl.registerLazySingleton(() => UpdateProfileCubit(sl<ProfileRepo>()));

  // Payment
  sl.registerLazySingleton<PaymentApi>(() => PaymentApi(sl<DioClient>().dio));
  sl.registerLazySingleton<PaymentRepo>(
    () => PaymentRepoImpl(sl<PaymentApi>()),
  );
  sl.registerLazySingleton(() => GetPaymentsCubit(sl<PaymentRepo>()));
  sl.registerFactory(() => GetInstallmentsCubit(sl<PaymentRepo>()));
  sl.registerFactory(() => RequestInstallmentPlanCubit(sl<PaymentRepo>()));
  sl.registerFactory(() => RequestTwoMonthInstallement(sl<PaymentRepo>()));
  sl.registerFactory(() => BuyCourseCubit(sl<PaymentRepo>()));
  sl.registerFactory(() => BuyLessonCubit(sl<PaymentRepo>()));
  sl.registerFactory(() => PayInstallmentCubit(sl<PaymentRepo>()));

  // Filters
  sl.registerLazySingleton<FilterDataApi>(
    () => FilterDataApi(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<FilterDataRepo>(
    () => FilterDataRepoImpl(sl<FilterDataApi>()),
  );
  sl.registerLazySingleton(() => FilterDataCubit(sl<FilterDataRepo>()));

  // Home
  sl.registerLazySingleton<HomeApi>(() => HomeApi(sl<DioClient>().dio));
  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl<HomeApi>()));
  sl.registerFactory(() => GetHomeDataCubit(sl<HomeRepo>()));
  sl.registerLazySingleton(() => GetAboutCubit(sl<HomeRepo>()));

  // Teachers
  sl.registerLazySingleton<TeacherApi>(() => TeacherApi(sl<DioClient>().dio));
  sl.registerLazySingleton<TeacherRepo>(
    () => TeacherRepoImpl(sl<TeacherApi>()),
  );
  sl.registerLazySingleton<GetTeachersCubit>(
    () => GetTeachersCubit(sl<TeacherRepo>()),
  );
  sl.registerFactory<GetTeacherDetailsCubit>(
    () => GetTeacherDetailsCubit(sl<TeacherRepo>()),
  );

  // Notifications
  sl.registerLazySingleton<NotificationsApi>(
    () => NotificationsApi(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<NotificationsRepo>(
    () => NotificationsRepoImpl(sl<NotificationsApi>()),
  );
  sl.registerFactory<GetNotificationsCubit>(
    () => GetNotificationsCubit(sl<NotificationsRepo>()),
  );
  sl.registerLazySingleton<MarkNotificationAsReadCubit>(
    () => MarkNotificationAsReadCubit(sl<NotificationsRepo>()),
  );
  sl.registerLazySingleton<DeleteNotificationCubit>(
    () => DeleteNotificationCubit(sl<NotificationsRepo>()),
  );

  // Support
  sl.registerLazySingleton<SupportApi>(() => SupportApi(sl<DioClient>().dio));
  sl.registerLazySingleton<SupportRepo>(
    () => SupportRepoImpl(sl<SupportApi>()),
  );
  sl.registerFactory<MySupportTicketsCubit>(
    () => MySupportTicketsCubit(sl<SupportRepo>()),
  );
  sl.registerFactory<SendSupportTicket>(
    () => SendSupportTicket(sl<SupportRepo>()),
  );

  // Reports
  sl.registerLazySingleton<ReportsApi>(() => ReportsApi(sl<DioClient>().dio));
  sl.registerLazySingleton<ReportsRepo>(
    () => ReportsRepoImpl(sl<ReportsApi>()),
  );

  sl.registerLazySingleton<DownloadReportCubit>(
    () => DownloadReportCubit(sl<ReportsRepo>()),
  );

  // Schedule
  sl.registerLazySingleton<ScheduleApi>(() => ScheduleApi(sl<DioClient>().dio));
  sl.registerLazySingleton<ScheduleRepo>(
    () => ScheduleRepoImpl(sl<ScheduleApi>()),
  );
  sl.registerFactory<GetOverduesCubit>(
    () => GetOverduesCubit(sl<ScheduleRepo>()),
  );
  sl.registerFactory<GetUpcomingsCubit>(
    () => GetUpcomingsCubit(sl<ScheduleRepo>()),
  );
}
