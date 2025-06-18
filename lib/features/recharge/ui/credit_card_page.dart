import 'package:flutter/material.dart';
import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../Utility/color_constants.dart';

class CreditCardPage extends StatelessWidget {
  const CreditCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomNormalText(
        text: 'Credit Cards List',
        color: subtextColor,
        size: 18,
      ),
    );
  }
}
