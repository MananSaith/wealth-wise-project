import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wealth_wise/app_module/consultant/consultant_list_screen.dart';
import 'package:wealth_wise/app_module/home/view/home_screen.dart';
import 'package:wealth_wise/app_module/profile/profile_screen.dart';

import '../../utils/app_color/app_color.dart';
import '../portfolio/view/portfolio_screen.dart';
import '../trade/view/trade_screen.dart';
import 'navbar_item.dart';

import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 2.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

class NavigationScreen extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> children = [
    HomeScreen(),
    ConsultantScreen(),
    TradeScreen(),
    PortfolioScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: children[navController.currentIndex.value],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              icon: CupertinoIcons.home,
              label: 'Home',
              index: 0,
              currentIndex: navController.currentIndex.value,
              onTap: navController.changeTab,
            ),
            BottomNavItem(
              icon: CupertinoIcons.rectangle_3_offgrid,
              label: 'Consultant',
              index: 1,
              currentIndex: navController.currentIndex.value,
              onTap: navController.changeTab,
            ),
            BottomNavItem(
              icon: Icons.show_chart,
              label: 'Trade',
              index: 2,
              currentIndex: navController.currentIndex.value,
              onTap: navController.changeTab,
            ),
            BottomNavItem(
              icon: CupertinoIcons.person_2,
              label: 'Portfolio',
              index: 3,
              currentIndex: navController.currentIndex.value,
              onTap: navController.changeTab,
            ),
            BottomNavItem(
              icon: CupertinoIcons.person,
              label: 'Profile',
              index: 4,
              currentIndex: navController.currentIndex.value,
              onTap: navController.changeTab,
            ),
          ],
        ),
      ),
    ));
  }
}



//
// class NavigationScreen extends StatefulWidget {
//   final int? index; // Optional index
//
//   const NavigationScreen({Key? key, this.index}) : super(key: key);
//
//   @override
//   State<NavigationScreen> createState() => _NavigationScreenState();
// }
//
// class _NavigationScreenState extends State<NavigationScreen> {
//   late int currentIndex;
//
//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.index ?? 2; // Use provided index or default to 0
//   }
//
//   final List<Widget> children = [
//      HomeScreen(),
//      ConsultantScreen(),
//     TradeScreen(),
//     PortfolioScreen(),
//     ProfileScreen(),
//   ];
//
//   void onTabTapped(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: children[currentIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.lightGray,
//               spreadRadius: 0,
//               blurRadius: 1,
//               offset: const Offset(0, -1),
//             ),
//           ],
//         ),
//         child: BottomAppBar(
//           color: AppColors.white,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               BottomNavItem(
//                 icon: CupertinoIcons.home,
//                 label: 'Home',
//                 index: 0,
//                 currentIndex: currentIndex,
//                 onTap: onTabTapped,
//               ),
//               BottomNavItem(
//                 icon: CupertinoIcons.rectangle_3_offgrid,
//                 label: 'Consultant',
//                 index: 1,
//                 currentIndex: currentIndex,
//                 onTap: onTabTapped,
//               ),
//               BottomNavItem(
//                 icon: Icons.show_chart, // Chart icon for trade
//                 label: 'Trade',
//                 index: 2,
//                 currentIndex: currentIndex,
//                 onTap: onTabTapped,
//               ),
//               BottomNavItem(
//                 icon: CupertinoIcons.person_2,
//                 label: 'Portfolio',
//                 index: 3,
//                 currentIndex: currentIndex,
//                 onTap: onTabTapped,
//               ),
//               BottomNavItem(
//                 icon: CupertinoIcons.person,
//                 label: 'Profile',
//                 index: 4,
//                 currentIndex: currentIndex,
//                 onTap: onTabTapped,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
