import 'package:flutter/material.dart';
import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../Utility/assets.dart';
import '../../../Utility/color_constants.dart';

class DebitPage extends StatelessWidget {
  const DebitPage({super.key});

  Widget _buildCard({
    required Color bgColor,
    required String bankName,
    required String logo,
    required String cardTypeIcon,
    bool isDefault = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: AssetImage(logo)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNormalText(text: bankName, color: Colors.black, size: 18),
                    const SizedBox(height: 6),
                    Image.asset(cardTypeIcon, height: 24),
                    const SizedBox(height: 6),
                    const Wrap(
                      spacing: 10,
                      runSpacing: 4,
                      children: [
                        CustomNormalText(text: 'Card No. **** **** 0123', color: subtextColor, size: 12),
                        CustomNormalText(text: 'Expiry Date: May 2030', color: subtextColor, size: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isDefault)
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const CustomNormalText(
                  text: 'Default',
                  color: Color(0xFF407BFF),
                  size: 14,
                  isbold: true,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildCard(
            bgColor: const Color(0xFFEAF4FF),
            bankName: "State Bank of India",
            logo: AppAssets.sbi,
            cardTypeIcon: AppAssets.mastercard,
            isDefault: true,
          ),
          _buildCard(
            bgColor: const Color(0xFFFFEBEB),
            bankName: "HDFC Bank",
            logo: AppAssets.hdfc,
            cardTypeIcon: AppAssets.visa,
          ),
          _buildCard(
            bgColor: const Color(0xFFF3E8FF),
            bankName: "Karnataka Bank",
            logo: AppAssets.karnatakaBank,
            cardTypeIcon: AppAssets.dinersClub,
          ),
        ],
      ),
    );
  }
}
