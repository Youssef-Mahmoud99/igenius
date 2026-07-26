import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:igenius/Features/Auth/data/models/auth_model.dart';
import 'package:igenius/Features/Auth/data/models/password_params.dart';
import 'Features/Account/data/models/profile_response_model.dart';
import 'Features/Account/presentation/cubits/profile_cubit.dart';
import 'Features/layout/layout_screen.dart';
import 'core/network/connectivity_monitor.dart';
import 'core/resources/routes_manager.dart';
import 'core/theme/theme_controller.dart';
import 'injection/service_locator.dart';

final layoutKey = GlobalKey<LayoutScreenState>();
AuthModel? registerParams = AuthModel();
PasswordParams? passwordParams = PasswordParams();

ProfileResponseModel? currentUser;

bool termsAgreed = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityService.instance.startMonitoring();
    });

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) => sl<ProfileCubit>(),
        child: MaterialApp.router(
          routerConfig: RoutesManager.router,
          debugShowCheckedModeBanner: false,
          title: 'Igenius',
          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
          // themeMode: AppTheme.lightTheme,
          // app fontfamily are in theme_controller  and styles_manager
          supportedLocales: const [Locale('en', ''), Locale('ar', '')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          useInheritedMediaQuery: true,
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          locale: Locale('en', ''),
          // WidgetsBinding.instance.window.locale,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
