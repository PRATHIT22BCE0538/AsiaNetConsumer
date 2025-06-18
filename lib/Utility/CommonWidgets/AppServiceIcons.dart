import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ServiceIconButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  const ServiceIconButton({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFF3F5F9),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 6,),
          CustomNormalText(text: label, color: Colors.black,size: 16,)
        ],
      ),
    );
  }
}
