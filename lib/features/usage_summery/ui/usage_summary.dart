import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/material.dart';

class UsageSummaryPage extends StatelessWidget {
  const UsageSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: const EdgeInsets.only(right: 10),
                    constraints: const BoxConstraints(),
                  ),
                  CustomNormalText(
                    text: 'Usage Summary',
                    color: Colors.black,
                    size: 22,
                    isbold: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Package Card
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSubText(text: 'Package Name:', color: textboxColor),
                      CustomNormalText(
                        text: 'Unlock_749_G',
                        color: Colors.white,
                        isbold: true,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Package Details
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSubText(
                      text: 'Usage Reset Time:', color: subtextColor),
                  CustomSubText(
                    text: '0 Days',
                    color: Colors.green,
                    isbold: true,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSubText(text: 'Package Type:', color: subtextColor),
                  CustomSubText(
                    text: 'Base',
                    color: Colors.black,
                    isbold: true,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSubText(text: 'Add-On Status:', color: subtextColor),
                  Chip(
                    label: Text("Active"),
                    backgroundColor: Colors.greenAccent,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSubText(text: 'Start Time:', color: subtextColor),
                  CustomSubText(
                    text: '15/04/2025',
                    color: Colors.black,
                    isbold: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Scrollable content
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildUsageCard(
                      title: "HSQ Limit",
                      color: const Color(0xFFDDF1FF),
                      imagePath: AppAssets.businessPlan,
                    ),
                    _buildUsageCard(
                      title: "Current Usage",
                      color: const Color(0xFFF3E8FF),
                      imagePath: AppAssets.investmentPlan1,
                    ),
                    _buildUsageCard(
                      title: "Balance",
                      color: const Color(0xFFFFF3D3),
                      imagePath: AppAssets.investmentPlan2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsageCard({
    required String title,
    required Color color,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Image background
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),

          // Text content on top of image
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNormalText(
                  text: title,
                  color: Colors.black,
                  size: 16,
                  isbold: true,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _GridItem(label: 'Download Limit', value: '0 MB'),
                    _GridItem(label: 'Upload Data', value: '0 MB'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _GridItem(label: 'Total Limit', value: '4096000 MB'),
                    _GridItem(label: 'Validity', value: 'Unlimited'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  final String label;
  final String value;

  const _GridItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 40) / 2.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNormalText(text: label, color: subtextColor, size: 14),
          const SizedBox(height: 4),
          CustomNormalText(
            text: value,
            color: Colors.black,
            size: 17,
            isbold: true,
          ),
        ],
      ),
    );
  }
}
