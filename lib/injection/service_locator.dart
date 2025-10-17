import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../core/network/dio_client.dart';
import '../core/network/network_info.dart';
import '../core/services/localization_service.dart';

final sl = GetIt.instance;

Future<void> init() async {

    
  // Network
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Dio Client
  final dioClient = await DioClient.create(); // هنا بيتبني مرة واحدة فقط
  sl.registerLazySingleton<DioClient>(() => dioClient);
  // to use dio :
    // final dio = sl<DioClient>().dio;
  

// Navigation
  sl.registerLazySingleton<GlobalKey<NavigatorState>>(() => GlobalKey<NavigatorState>());
  // Storage
  sl.registerLazySingleton<GetStorage>(() => GetStorage());
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Localization
    sl.registerLazySingleton<LocalizationService>(() => LocalizationService());

    // to use these: 
    //   final languageCode = sl<LocalizationService>().languageCode;
    //   final strings = sl<LocalizationService>().strings;



  // -------------------------------
  // ✳️ Example: Register APIs & Repos
  // بعد كده لما تبني الـ features
  // تقدر تسجلها كده:
  //
  // sl.registerLazySingleton<AuthApi>(
  //   () => AuthApi(sl<DioClient>().dio),
  // );
  //
  // sl.registerLazySingleton<AuthRepo>(
  //   () => AuthRepoImpl(sl<AuthApi>()),
  // );
  //
  // sl.registerFactory(() => LoginCubit(sl<AuthRepo>()));
  // -------------------------------
}
