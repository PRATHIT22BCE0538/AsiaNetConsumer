import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../../routes/app_routes.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: const EdgeInsets.only(right: 10),
                  constraints: const BoxConstraints(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNormalText(text: 'Help & Support', color: Colors.black,size: 22,isbold: true,),
                    CustomNormalText(text: 'How may we help you?', color: Colors.black,size: 12,)
                  ],
                )
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: "Search for issues",
                prefixIcon: const ImageIcon(AssetImage(AppAssets.search),color: Colors.black,),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 20),

            // Cards for Complaint Booking & New Connection
            Row(
              children: [
                _InfoCard(
                  title: "Complaint\nBooking",
                  subtitle: "Raise a complaint regarding your service",
                  imagePath: AppAssets.help1,
                  onpressed: (){Get.toNamed(Routes.raisecomplaint);},
                ),
                const SizedBox(width: 12),
                _InfoCard(
                  title: "New Connection\nEnquiry",
                  subtitle: "Get details about a new connection",
                  imagePath: AppAssets.help2,
                  onpressed: (){},
                ),
              ],
            ),

            const SizedBox(height: 24),
            CustomNormalText(text: 'Contact Us', color: Colors.black,size: 18,isbold: true,),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _ContactOption(
                  label: "Customer Helpline",
                  icon: AppAssets.helpline,
                  bgColor: Color(0xFFE4FFDF),
                ),
                _ContactOption(
                  label: "Broadband Helpline",
                  icon: AppAssets.routerHelp,
                  bgColor: Color(0xFFFFF3C7),
                ),
                _ContactOption(
                  label: "Email Support",
                  icon: AppAssets.mailHelp,
                  bgColor: Color(0xFFF2E8FF),
                ),
              ],
            ),

            const SizedBox(height: 24),
            CustomNormalText(text: 'Top FAQ', color: Colors.black,size: 18,isbold: true,),
            const SizedBox(height: 12),
            const _FAQItem(question: "How to check data usage?"),
            const _FAQItem(question: "Why is my internet slow?"),
            const _FAQItem(question: "How do I change my broadband plan?"),
            const _FAQItem(question: "How to reset my router password?"),

            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {},
                child:  CustomNormalText(text: 'See ALL FAQ →', color: primaryColor,size: 14,isUnderlined: true,),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title, subtitle, imagePath;
  final Function() onpressed;
  const _InfoCard({
    required this.title,
    required this.subtitle,
    required this.imagePath, required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onpressed,
        child: Container(
          height: 240,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFDDEEFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: textboxColor, // Change this to any color you want
              width: 1.5,         // Optional: Set border width
            ),
          ),
          child: Stack(
            children: [
              // Card content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomNormalText(text: title, color: Colors.black,isbold: true,size: 18,),
                  const SizedBox(height: 6),
                  CustomNormalText(text: subtitle, color: Colors.black,size: 14,),
                  const Spacer(),

                  // Chevron and space holder for image
                  Row(
                    children: const [
                      Icon(Icons.chevron_right_rounded,size: 40,color: Color(0xFF333333),),
                    ],
                  ),
                ],
              ),

              // Positioned image at bottom-right
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  imagePath,
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactOption extends StatelessWidget {
  final String label;
  final String icon;
  final Color bgColor;

  const _ContactOption({
    required this.label,
    required this.icon,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 130,
        padding: const EdgeInsets.symmetric(vertical: 22),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ImageIcon(AssetImage(icon),size: 32,),
            const SizedBox(height: 8),
            CustomNormalText(text: label, color: Colors.black,isCenter: true,size: 15,)
          ],
        ),
      ),
    );
  }
}

class _FAQItem extends StatelessWidget {
  final String question;

  const _FAQItem({required this.question});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title:CustomNormalText(text: question, color: Colors.black,size: 14,),
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child:CustomNormalText(text: 'Answer coming soon...', color: textboxColor,size: 13,)
        ),
      ],
    );
  }
}
