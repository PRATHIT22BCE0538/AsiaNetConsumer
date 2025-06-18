import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utility/assets.dart';
import '../../../Utility/color_constants.dart';
import '../../../routes/app_routes.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){Get.toNamed(Routes.profile);},
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: const EdgeInsets.only(right: 8),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  CustomNormalText(text: 'Account Information', color: Colors.black,isbold: true,size: 22,)
                ],
              ),

              const SizedBox(height: 16),

              const _SectionTitle(title: "Personal Information"),
              _AccountInfoTile(icon: AppAssets.person_info, title: 'Name', info: 'Girish Thorat', iconColor: primaryColor),
              _buildDivider(),
              _AccountInfoTile(icon: AppAssets.phone, title: 'Mobile Number', info: '76********', iconColor: primaryColor),
              _buildDivider(),
              _AccountInfoTile(icon: AppAssets.mail, title: 'Email ID', info: 'girish.girish@asianet.com', iconColor: primaryColor),

              const SizedBox(height: 20),
              const _SectionTitle(title: "Account Information"),
              _AccountInfoTile(icon: AppAssets.person_info, title: 'Business Partner ID', info: '1000110986', iconColor: iconColorRed),
              _buildDivider(),
              _AccountInfoTile(icon: AppAssets.phone, title: 'Contract Account Number', info: '000000088361', iconColor: iconColorRed),
              _buildDivider(),
              _AccountInfoTile(icon: AppAssets.mail, title: 'Associate ID', info: '1000001075', iconColor: iconColorRed),

              const SizedBox(height: 20),
              const _SectionTitle(title: "Service Details"),
              _AccountInfoTile(icon: AppAssets.internet, title: 'Line of Business(LOB)', info: 'ISP', iconColor: iconColorGreen),
              _buildDivider(),
              _AccountInfoTile(icon: AppAssets.customer, title: 'Customer Type', info: 'ZIND', iconColor: iconColorGreen),
              _buildDivider(),
              _AccountInfoTile(icon: AppAssets.split, title: 'Division', info: 'ABB', iconColor: iconColorGreen),
              _buildDivider(),
              _AccountInfoTile(icon: AppAssets.connect, title: 'Connection Type', info: 'Postpaid', iconColor: iconColorGreen),

              const SizedBox(height: 20),
              const _SectionTitle(title: "Network & Location"),
              _AccountInfoTile(icon: AppAssets.cube, title: 'Fiber Node', info: 'KNT/79/OLT 05/ELAMAKKARA RE-TX/C1-P2', iconColor: iconColorYellow),
              _buildDivider(),
              _AccountInfoTile(
                icon: AppAssets.homeAccInfo,
                title: 'Installation Address',
                info: 'ASWATHY NIVAS, PACHALAM, THACHANATH LANE\nOPP LOURD HOSPITAL, Kochi, Kerala, Kochi North – 682012',
                iconColor: iconColorYellow,
              ),
              _buildDivider(),
              _AccountInfoTile(
                icon: AppAssets.address,
                title: 'Billing Address',
                info: 'THACHANATH LANE OPP LOURD HOSPITAL,\nEKM NORTH (GA06), Cochin, KERALA – 682012',
                iconColor: iconColorYellow,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() => Divider(color: dividerColor, thickness: 1);
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 12),
      child: CustomNormalText(text: title, color: Colors.grey.shade800,size: 16,)
    );
  }
}

class _AccountInfoTile extends StatelessWidget {
  final String icon;
  final String title;
  final String info;
  final Color iconColor;

  const _AccountInfoTile({
    required this.icon,
    required this.title,
    required this.info,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: iconColor.withOpacity(0.1),
        child: ImageIcon(
          AssetImage(icon),
          color: iconColor,
          size: 28,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNormalText(text: title, color: textboxColor,size: 14,),
          const SizedBox(height: 2),
          CustomNormalText(text: info, color: Colors.black,size: 16,)
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}
