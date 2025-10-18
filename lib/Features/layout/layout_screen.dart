import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/theme/app_colors.dart';

import '../Home/presentation/views/pages/Home_screen.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({Key? key, required this.isGuest}) : super(key: key);
  final bool isGuest;
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomePage(isGuest: isGuest),
      Center(child: Text('Courses Screen')),
      Center(child: Text('Teachers Screen')),
      Center(child: Text('Account Screen')),
    ];
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, index, _) {
        return Scaffold(
          body: _screens[index],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: BottomNavigationBar(
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
          ),
        );
      },
    );
  }
}
