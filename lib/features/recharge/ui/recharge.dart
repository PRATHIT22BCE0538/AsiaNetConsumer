import 'package:asianetconsumer/features/recharge/ui/upi_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../Utility/CommonWidgets/AppTextFormField.dart';
import '../../../Utility/color_constants.dart';
import '../../../Utility/assets.dart';
import 'credit_card_page.dart';
import 'debit_card_page.dart';

class Recharge extends StatefulWidget {
  const Recharge({super.key});

  @override
  State<Recharge> createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  final TextEditingController number = TextEditingController();
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    number.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
          child: CustomNormalText(
            text: title,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  padding: const EdgeInsets.only(right: 10),
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const CustomNormalText(
                  text: 'Recharge',
                  color: Colors.black,
                  size: 22,
                  isbold: true,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Wallet Info
            Row(
              children: [
                SvgPicture.asset(AppAssets.wallet, height: 25, width: 25),
                const SizedBox(width: 12),
                const CustomNormalText(text: 'Wallet Balance', color: Colors.black, size: 18),
              ],
            ),
            const SizedBox(height: 5),
            const CustomNormalText(text: '₹ 1550.00', color: Colors.black, isbold: true, size: 40),

            const SizedBox(height: 30),

            // Amount
            const CustomSubText(text: 'Amount', color: Colors.black),
            const SizedBox(height: 10),
            CustomTextFormField(
              hint: 'Enter Amount',
              textEditingController: number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Amount is required';
                final parsed = int.tryParse(value);
                if (parsed == null) return 'Enter a valid number';
                if (parsed < 100) return 'Minimum ₹100 required';
                return null;
              },
            ),
            const SizedBox(height: 5),
            const CustomNormalText(text: 'Minimum Rs. 100 Required', color: subtextColor, size: 14),
            const SizedBox(height: 10),

            // Chips
            SizedBox(
              height: 40,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [100, 200, 300, 500, 1000, 'Other'].map((amount) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          number.text = amount.toString();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade400, width: 1),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '₹$amount',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

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
                onPageChanged: (index) => setState(() => _selectedIndex = index),
                children: const [
                  DebitCardPage(),
                  CreditCardPage(),
                  UpiPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
