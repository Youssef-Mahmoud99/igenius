import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Account/presentation/views/pages/account_screen.dart';
import 'package:igenius/Features/Courses/presentation/views/pages/courses_screen.dart';
import 'package:igenius/Features/Home/presentation/cubits/get_home_data_cubit.dart';
import 'package:igenius/Features/Notifications/presentation/cubits/notifications_cubit.dart';
import 'package:igenius/Features/Teachers/presentation/views/pages/teachers_screen.dart';
import 'package:igenius/core/theme/app_colors.dart';
import '../../core/base/cubit/base_state.dart';
import '../../core/base/models/base_response.dart';
import '../../core/constants/app_keys.dart';
import '../../core/services/secure_storage_service.dart';
import '../../core/widgets/Shimmer/account_shimmer.dart';
import '../../core/widgets/Shimmer/home_shimmer.dart';
import '../../injection/service_locator.dart';
import '../Account/data/models/profile_response_model.dart';
import '../Account/presentation/cubits/profile/profile_cubit.dart';
import '../Account/presentation/views/pages/guest_account_screen.dart';
import '../Auth/presentation/cubits/auth_cubit.dart';
import '../Home/presentation/views/pages/Home_screen.dart';
import '../filters/presentation/cubits/filter_data_cubit.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key, required this.isGuest}) : super(key: key);
  final bool isGuest;

  @override
  State<LayoutScreen> createState() => LayoutScreenState();
}

class LayoutScreenState extends State<LayoutScreen> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  bool _checkingToken = true;
  bool _hasToken = false;

  void setIndex(int index) => _currentIndex.value = index;

  @override
  void initState() {
    super.initState();
    _resolveAuth();
    context.read<GetHomeDataCubit>().getHomeData();
  }

  Future<void> _resolveAuth() async {
    final token = await SecureStorageService.read(AppKeys.token);
    _hasToken = token != null;

    if (_hasToken) {
      context.read<GetNotificationsCubit>().getNotifications();

      context.read<ProfileCubit>().getProfile();
    }
    if (mounted) setState(() => _checkingToken = false);
  }

  /// تتنادى من اللوجين/اللوجاوت عشان تعيد التحقق من جديد
  void refreshAfterAuthChange() {
    setState(() => _checkingToken = true);
    _resolveAuth();
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingToken) {
      return const Scaffold(body: HomeShimmer());
    }
    if (!_hasToken) {
      return _buildScaffold(isLoading: false, isGuest: true);
    }

    // فيه توكن -> نتابع حالة الـ ProfileCubit عشان نعرف نعرض شيمر ولا الشاشة الحقيقية
    return BlocBuilder<
      ProfileCubit,
      BaseCubitState<BaseResponse<ProfileResponseModel>>
    >(
      builder: (context, state) {
        final bool isSuccess =
            state is SuccessState<BaseResponse<ProfileResponseModel>>;
        final bool isError =
            state is ErrorState<BaseResponse<ProfileResponseModel>>;
        final bool isLoading = !isSuccess && !isError;

        // لو فيه توكن وحصل error حقيقي (مش مشكلة إنه مش مسجل) نعرضه guest
        // كـ fallback بدل ما الشاشة تفضل عالقة — عدّلها لو عندك تفريق أدق للأخطاء
        final bool isGuest = isError;

        return _buildScaffold(isLoading: isLoading, isGuest: isGuest);
      },
    );
  }

  Widget _buildScaffold({required bool isLoading, required bool isGuest}) {
    final List<Widget> screens = [
      isLoading ? const HomeShimmer() : HomePage(isGuest: isGuest),
      BlocProvider(
        create: (context) => sl<FilterDataCubit>(),
        child: CoursesScreen(),
      ),
      BlocProvider(
        create: (context) => sl<FilterDataCubit>(),
        child: TeachersScreen(),
      ),
      isLoading
          ? const AccountShimmer()
          : (isGuest
              ? const GuestAccountScreen()
              : BlocProvider(
                create: (context) => sl<AuthCubit>(),
                child: AccountScreen(),
              )),
    ];

    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, index, _) {
        return Scaffold(
          body: screens[index],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: index,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.grey,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
            unselectedLabelStyle: TextStyle(fontSize: 12.sp),
            onTap: (newIndex) => _currentIndex.value = newIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                label: 'Courses',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups_outlined),
                label: 'Teachers',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
