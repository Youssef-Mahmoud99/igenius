import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/views/pages/courses_screen.dart';
import 'package:igenius/Features/Teachers/presentation/views/pages/teachers_screen.dart';
import 'package:igenius/core/theme/app_colors.dart';
import '../Account/presentation/views/pages/about_us_screen.dart';
import '../Home/presentation/views/pages/Home_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key, required this.isGuest}) : super(key: key);
  final bool isGuest;

  @override
  State<LayoutScreen> createState() => LayoutScreenState();
}

class LayoutScreenState extends State<LayoutScreen> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  void setIndex(int index) {
    _currentIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomePage(isGuest: widget.isGuest),
      CoursesScreen(),
      TeachersScreen(),
      AboutUsScreen(),
    ];

    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, index, _) {
        return Scaffold(
          body: _screens[index],
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
