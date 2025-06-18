// lib/features/bill_details/bill_details.dart
import 'package:flutter/material.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';

import '../../../Utility/CommonWidgets/AppCustomButton.dart';
import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../Utility/CommonWidgets/common_widgets.dart';
import '../../../Utility/assets.dart';

class BillDetails extends StatefulWidget {
  const BillDetails({Key? key}) : super(key: key);

  @override
  _BillDetailsState createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<Map<String, String>> _breakupData = [
    {
      'Monthly Rental': 'Rs. 800.00',
      'Other Usage Charges': 'Rs. 200.00',
      'Discount': '-Rs. 100.00',
      'Total Taxes': 'Rs. 134.00',
      'Total Amount Payable': 'Rs. 1234.56',
    },
    {
      'Monthly Rental': 'Rs. 600.00',
      'Other Usage Charges': 'Rs. 150.00',
      'Discount': '-Rs. 50.00',
      'Total Taxes': 'Rs. 120.00',
      'Total Amount Payable': 'Rs. 820.00',
    },
  ];

  void _onToggle(int idx) {
    setState(() => _selectedIndex = idx);
    _pageController.animateToPage(
      idx,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // current page’s payable for the Pay button
    final currentPayable = _breakupData[_selectedIndex]['Total Amount Payable']!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // === HEADER & WALLET SECTION (fixed height) ===
            SizedBox(
              height: 240,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Background and Content
                  Container(
                    width: double.infinity,
                    color: const Color(0xFFEFF1FF),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                                  padding: EdgeInsets.zero, // Removes all internal padding
                                  constraints: const BoxConstraints(), // Removes default min size
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                              const SizedBox(width: 6), // Small space between icon and text
                              const CustomNormalText(
                                text: 'Bills',
                                color: Colors.black,
                                size: 22,
                                isbold: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomNormalText(
                                      text: 'Wallet Balance',
                                      color: subtextColor,
                                      size: 16,
                                    ),
                                    const SizedBox(height: 4),
                                    const CustomNormalText(
                                      text: '₹1550.00',
                                      color: black,
                                      isbold: true,
                                      size: 32,
                                    ),
                                    const SizedBox(height: 12),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.add, size: 16, color: Colors.white),
                                      label: const Text(
                                        'Add money',
                                        style: TextStyle(color: Colors.white, fontSize: 14),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: secondaryColor,
                                        minimumSize: const Size(140, 40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        elevation: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Positioned Wallet Image
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SizedBox(
                      width: 250, // adjust as needed
                      height: 250,
                      child: Image.asset(
                        AppAssets.walletbill,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 48, // Fixed height for visibility
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(color: walletbg), // Left background
                      ),
                      Expanded(
                        child: Container(color: bgColor), // Right background
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          _buildToggleTab('ISP', 0),
                          _buildToggleTab('CATV', 1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PageView of blocks + pay button
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 300,
                      child: PageView(
                        physics: BouncingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (i) => setState(() => _selectedIndex = i),
                        children: List.generate(2, (i) {
                          final payable = _breakupData[i]['Total Amount Payable']!;
                          return Column(
                            children: [
                              GridView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 1.8,
                                ),
                                children: [
                                  // Dynamic Amount Payable card:
                                  DetailBlock(
                                    title: 'Amount Payable',
                                    value: payable,
                                    assetPath: AppAssets.icon_money,
                                  ),
                                  const DetailBlock(
                                    title: 'Bill Generated On',
                                    value: '20 May 2025',
                                    assetPath: AppAssets.iconReceipt,
                                  ),
                                  const DetailBlock(
                                    title: 'Due Date',
                                    value: '08 June 2025',
                                    assetPath: AppAssets.icon_calendar,
                                  ),
                                  const DetailBlock(
                                    title: 'Bill Cycle',
                                    value: '01 May–\n31 May 25',
                                    assetPath: AppAssets.icon_cycle,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              CustomButton(
                                buttonName: 'Pay $payable',
                                onPressed: () {},
                                iconEnable: true,
                                iconData: Icons.payment,
                              ),

                            ],
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 24),
                    const CustomNormalText(
                      text: 'Bill Breakup',
                      color: black,
                      isbold: true,
                    ),
                    const SizedBox(height: 8),
                    ServicePlanDetailsTable(
                      rows: _breakupData[_selectedIndex],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonName: 'Help',
                            onPressed: () {},
                            isOutLine: true,
                            iconEnable: true,
                            iconData: Icons.help_outline,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            buttonName: 'Download',
                            onPressed: () {},
                            iconEnable: true,
                            iconData: Icons.download,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleTab(String label, int idx) {
    final selected = _selectedIndex == idx;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onToggle(idx),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? primaryColor : Colors.transparent,
            borderRadius: idx == 0
                ? const BorderRadius.horizontal(left: Radius.circular(8),right: Radius.circular(8))
                : const BorderRadius.horizontal(right: Radius.circular(8),left: Radius.circular(8)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : subtextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
