import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:igenius/Features/Auth/presentation/cubits/auth_cubit.dart';

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
import '../Features/Courses/presentation/cubits/course_details_cubit.dart';
import '../Features/Courses/presentation/cubits/courses_by_teacher_cubit.dart';
import '../Features/Courses/presentation/cubits/courses_cubit.dart';
import '../Features/Courses/presentation/cubits/home_courses_cubit.dart';
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
  sl.registerFactory(() => PasswordCubit(sl<PasswordRepo>()));

  // Courses
  sl.registerLazySingleton<CoursesApi>(() => CoursesApi(sl<DioClient>().dio));
  sl.registerLazySingleton<CoursesRepo>(() => CoursesRepoImpl(sl<CoursesApi>()));
  sl.registerFactory(() => CoursesCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => CourseDetailsCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => HomeCoursesCubit(sl<CoursesRepo>()));
  sl.registerFactory(() => CoursesByTeacherCubit(sl<CoursesRepo>()));
}