import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utility/color_constants.dart';
import '../../../Utility/assets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomHeadingText(
                    text: 'My Profile',
                    color: Colors.black,
                    isbold: true,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.login);
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: const Color(0xFFF2F4FC),
                      child: Image.asset(
                        AppAssets.logout,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Profile Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(AppAssets.avatar),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CustomNormalText(
                            text: 'Girish Thorat',
                            color: Colors.white,
                            isbold: true,
                            size: 20,
                          ),
                          SizedBox(height: 4),
                          CustomNormalText(
                            text: 'girish.girish@asianet.com    |    76********',
                            color: textboxColor,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Profile Options
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  children: [
                    _ProfileTile(
                      icon: AppAssets.person,
                      title: 'Account Information',
                      onPressed: () => Get.toNamed(Routes.accountinfo),
                    ),
                    const Divider(color: textboxColor, thickness: 1),
                    _ProfileTile(
                      icon: AppAssets.subscription,
                      title: 'Active Subscription',
                      onPressed: () => Get.toNamed(Routes.login),
                    ),
                    const Divider(color: textboxColor, thickness: 1),
                    _ProfileTile(
                      icon: AppAssets.payment,
                      title: 'Billing History',
                      onPressed: () => Get.toNamed(Routes.billinghistory),
                    ),
                    const Divider(color: textboxColor, thickness: 1),
                    _ProfileTile(
                      icon: AppAssets.wallet_2,
                      title: 'Payment Method',
                      onPressed: () => Get.toNamed(Routes.paymentmethod),
                    ),
                    const Divider(color: textboxColor, thickness: 1),
                    _ProfileTile(
                      icon: AppAssets.service,
                      title: 'Setting & Support',
                      onPressed: () => Get.toNamed(Routes.login),
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
}

class _ProfileTile extends StatelessWidget {
  final String icon;
  final String title;
  final Function() onPressed;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: ImageIcon(
            AssetImage(icon),
            color: primaryColor,
          ),
        ),
        title: CustomNormalText(text: title, color: Colors.black),
        trailing: const Icon(Icons.chevron_right),
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
      ),
    );
  }
}
