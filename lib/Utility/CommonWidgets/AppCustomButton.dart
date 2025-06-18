import 'package:flutter/material.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final Function()? onPressed;
  final bool isEnable;
  final bool isOutLine;
  final bool iconEnable;
  final bool iconAfter;     // new flag
  final IconData? iconData;
  final Widget? customIcon;

  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.isEnable = true,
    this.isOutLine = false,
    this.iconEnable = false,
    this.iconAfter = false,  // default remains false
    this.iconData,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColorValue = isEnable
        ? (isOutLine ? bgColor : primaryColor)
        : Colors.grey.shade400;

    final Color textColor = isOutLine ? primaryColor : Colors.white;

    Widget? iconWidget;
    if (iconEnable) {
      if (customIcon != null) {
        iconWidget = customIcon!;
      } else if (iconData != null) {
        iconWidget = Icon(iconData, color: textColor, size: 16);
      }
    }

    // Build the children in the correct order
    List<Widget> children;
    if (iconWidget != null && iconAfter) {
      children = [
        Text(
          buttonName,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 6),
        iconWidget,
      ];
    } else if (iconWidget != null && !iconAfter) {
      children = [
        iconWidget,
        const SizedBox(width: 6),
        Text(
          buttonName,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ];
    } else {
      children = [
        Text(
          buttonName,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ];
    }

    return GestureDetector(
      onTap: isEnable ? onPressed : null,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: bgColorValue,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor, width: 1.5),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}