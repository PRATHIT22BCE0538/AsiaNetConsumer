import 'package:flutter/material.dart';
import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../Utility/color_constants.dart';

class UpiPage extends StatelessWidget {
  const UpiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomNormalText(
        text: 'UPI Linked Accounts',
        color: subtextColor,
        size: 18,
      ),
    );
  }
}
