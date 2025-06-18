import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomButton.dart';
import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/material.dart';

import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../recharge/ui/upi_page.dart';
import 'credit_page.dart';
import 'debit_page.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onTabTap(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  Widget _buildTab(String title, int index) {
    final bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomNormalText(text: title, color: isSelected ? Colors.white : Colors.black,)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: const EdgeInsets.only(right: 10),
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  CustomNormalText(text: 'Payment Method', color: Colors.black,size: 22,isbold: true,)
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: CustomNormalText(text: 'Saved UPI/Cards', color: subtextColor,size: 16,)
              ),
              // Tabs
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4FC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildTab("Debit", 0),
                    _buildTab("Credit", 1),
                    _buildTab("UPI", 2),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // PageView
              Expanded(
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) =>
                      setState(() => _selectedIndex = index),
                    children: const [
                      DebitPage(),
                      CreditPage(),
                      UpiPage(),
                    ],
                ),
              ),

              const SizedBox(height: 10),

              CustomButton(buttonName: 'Change Default Payment Method', onPressed: (){}),
              const SizedBox(height: 12),
              CustomButton(buttonName: 'Add New UPI/Card', onPressed: (){},isOutLine: true,iconEnable: true,iconData: Icons.add_circle_outline,),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }

}
