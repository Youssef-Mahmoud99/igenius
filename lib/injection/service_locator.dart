import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:igenius/Features/Account/data/network/profile_api.dart';
import 'package:igenius/Features/Account/data/repos/profile_repo.dart';
import 'package:igenius/Features/Auth/presentation/cubits/auth_cubit.dart';

import '../Features/Account/data/repos/profile_repo_impl.dart';
import '../Features/Account/presentation/cubits/profile_cubit.dart';
import '../Features/Account/presentation/cubits/update_profile_cubit.dart';
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
import '../Features/payment/presentation/cubits/request_installment_cubit.dart';
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
  sl.registerLazySingleton<PasswordRepo>(() => PasswordRepoImpl(sl<PasswordApi>()));
  sl.registerLazySingleton(() => PasswordCubit(sl<PasswordRepo>()));

  // Courses
  sl.registerLazySingleton<CoursesApi>(() => CoursesApi(sl<DioClient>().dio));
  sl.registerLazySingleton<CoursesRepo>(() => CoursesRepoImpl(sl<CoursesApi>()));
sl.registerLazySingleton(() => CoursesCubit(sl<CoursesRepo>()));
  sl.registerLazySingleton(() => CourseDetailsCubit(sl<CoursesRepo>()));
  sl.registerLazySingleton(() => HomeCoursesCubit(sl<CoursesRepo>()));
  sl.registerLazySingleton(() => CoursesByTeacherCubit(sl<CoursesRepo>()));


  // My Courses
sl.registerLazySingleton(() => MyCoursesCubit(sl<CoursesRepo>()));
sl.registerLazySingleton(() => MyCourseDetailsCubit(sl<CoursesRepo>()));

// Lessons
sl.registerLazySingleton(() => LessonContentCubit(sl<CoursesRepo>()));
sl.registerLazySingleton(() => MarkAttendanceCubit(sl<CoursesRepo>()));

// Assignments
sl.registerLazySingleton(() => AssignmentsCubit(sl<CoursesRepo>()));
sl.registerLazySingleton(() => AssignmentDetailsCubit(sl<CoursesRepo>()));
sl.registerLazySingleton(() => AssignmentAttemptsCubit(sl<CoursesRepo>()));
sl.registerLazySingleton(() => SubmitAssignmentCubit(sl<CoursesRepo>()));

// Exams
sl.registerLazySingleton(() => MyExamsCubit(sl<CoursesRepo>()));
sl.registerLazySingleton(() => MyExamDetailsCubit(sl<CoursesRepo>()));
sl.registerLazySingleton(() => ExamAttemptsCubit(sl<CoursesRepo>()));
sl.registerLazySingleton(() => SubmitExamCubit(sl<CoursesRepo>()));


// Profile
       sl.registerLazySingleton<ProfileApi>(() => ProfileApi(sl<DioClient>().dio));
  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(sl<ProfileApi>()));
  sl.registerLazySingleton(()=> ProfileCubit(sl<ProfileRepo>()));
  sl.registerLazySingleton(() => UpdateProfileCubit(sl<ProfileRepo>()));



  // Payment
  sl.registerLazySingleton<PaymentApi>(() => PaymentApi(sl<DioClient>().dio));
  sl.registerLazySingleton<PaymentRepo>(
      () => PaymentRepoImpl(sl<PaymentApi>()));
  sl.registerLazySingleton(() => GetPaymentsCubit(sl<PaymentRepo>()));
  sl.registerLazySingleton(() => GetInstallmentsCubit(sl<PaymentRepo>()));
  sl.registerLazySingleton(() => RequestInstallmentCubit(sl<PaymentRepo>()));
  sl.registerLazySingleton(() => BuyCourseCubit(sl<PaymentRepo>()));
  sl.registerLazySingleton(() => BuyLessonCubit(sl<PaymentRepo>()));
  sl.registerLazySingleton(() => PayInstallmentCubit(sl<PaymentRepo>()));


  // Filters
  sl.registerLazySingleton<FilterDataApi>(() => FilterDataApi(sl<DioClient>().dio));
  sl.registerLazySingleton<FilterDataRepo>(
      () => FilterDataRepoImpl(sl<FilterDataApi>()));
  sl.registerLazySingleton(() => FilterDataCubit(sl<FilterDataRepo>()));


}