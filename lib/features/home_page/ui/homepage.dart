import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:asianetconsumer/features/home_page/ui/cart.dart';
import 'package:asianetconsumer/features/home_page/ui/home.dart';
import 'package:asianetconsumer/features/home_page/ui/notification.dart';
import 'package:asianetconsumer/features/home_page/ui/profile.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int myCurrentItem = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: myCurrentItem);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      myCurrentItem = index;
    });
  }

  void onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: BouncingScrollPhysics(),
        children: [
          Home(),
          NotificationPage(),
          CartPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 25),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 25,
              offset: const Offset(8, 2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            navItem(0, AppAssets.home, AppAssets.homeFilled, "Home"),
            navItem(1, AppAssets.notification, AppAssets.notificationFilled, "Notification"),
            navItem(2, AppAssets.cart, AppAssets.cartFilled, "Cart"),
            navItem(3, AppAssets.profile, AppAssets.profileFilled, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget navItem(int index, String icon, String filledIcon, String label) {
    bool isSelected = myCurrentItem == index;
    bool showDot = index == 1 || index == 2; // Show dot for Notification and Cart

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 12 : 0, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  isSelected ? filledIcon : icon,
                  width: 24,
                  height: 24,
                  color: isSelected ? Colors.white : primaryColor,
                ),
                if (showDot)
                  Positioned(
                    right: -1,
                    top: 1,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

}
