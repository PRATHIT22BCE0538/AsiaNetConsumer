import 'package:flutter/material.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import '../../../Utility/CommonWidgets/AppCustomText.dart';
import 'installation_page.dart';
import 'device_page.dart';
import 'plan_subscription_page.dart';

class PlanDetailsDashboard extends StatefulWidget {
  const PlanDetailsDashboard({Key? key}) : super(key: key);

  @override
  _PlanDetailsDashboardState createState() => _PlanDetailsDashboardState();
}

class _PlanDetailsDashboardState extends State<PlanDetailsDashboard> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;

    final isAdjacent = (_currentIndex - index).abs() == 1;

    if (isAdjacent) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.jumpToPage(index);
    }

    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 10),
                CustomNormalText(
                  text: 'Plan Details',
                  color: Colors.black,
                  size: 22,
                  isbold: true,
                ),
              ],
            ),
          ),

          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildTab('Installation', 0),
                const SizedBox(width: 8),
                _buildTab('Device', 1),
                const SizedBox(width: 8),
                _buildTab('Plan Subscription', 2),
              ],
            ),
          ),

          // PageView
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: const [
                InstallationPage(),
                DevicePage(),
                PlanSubscriptionPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final bool isSelected = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabTapped(index),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

}
