import 'dart:ffi';

import 'package:asianetconsumer/Utility/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomBigHeadingText extends StatelessWidget {
  final String text;
  final Color color;
  final bool isUnderlined;
  final bool isbold;
  const CustomBigHeadingText({super.key, required this.text, required this.color, this.isUnderlined=false, this.isbold=false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 38,
        fontWeight: isbold?FontWeight.w900:FontWeight.normal,
        color: color,
        decoration: isUnderlined?TextDecoration.underline:TextDecoration.none,
        decorationColor: color,
        fontFamily: Constants.font,
        decorationThickness: 1
      ),
    );
  }
}

class CustomHeadingText extends StatelessWidget {
  final String text;
  final Color color;
  final bool isUnderlined;
  final bool isbold;
  const CustomHeadingText({super.key, required this.text, required this.color, this.isUnderlined=false, this.isbold=false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 28,
          fontWeight: isbold?FontWeight.w600:FontWeight.normal,
          color: color,
          decoration: isUnderlined?TextDecoration.underline:TextDecoration.none,
          decorationColor: color,
          fontFamily: Constants.font,
          decorationThickness: 1
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final bool isUnderlined;
  final bool isbold;
  final double size;
  const CustomText({super.key, required this.text, required this.color, this.isUnderlined=false, this.isbold=false, this.size=23});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          fontWeight: isbold?FontWeight.w700:FontWeight.w400,
          color: color,
          decoration: isUnderlined?TextDecoration.underline:TextDecoration.none,
          decorationColor: color,
          fontFamily: Constants.font,
          decorationThickness: 1
      ),
    );
  }
}

class CustomNormalText extends StatelessWidget {
  final String text;
  final Color color;
  final bool isUnderlined;
  final bool isbold;
  final bool isCenter;
  final double size;
  const CustomNormalText({super.key, required this.text, required this.color, this.isUnderlined=false, this.isbold=false, this.size=18, this.isCenter=false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isCenter?TextAlign.center:TextAlign.start,
      style: TextStyle(
          fontSize: size,
          fontWeight: isbold?FontWeight.w600:FontWeight.w500,
          color: color,
          decoration: isUnderlined?TextDecoration.underline:TextDecoration.none,
          decorationColor: color,
          fontFamily: Constants.font,
          decorationThickness: 1
      ),
    );
  }
}

class CustomSubText extends StatelessWidget {
  final String text;
  final Color color;
  final bool isUnderlined;
  final bool isbold;
  final bool isCenter;
  const CustomSubText({super.key, required this.text, required this.color, this.isUnderlined=false, this.isbold=false, this.isCenter=false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isCenter?TextAlign.center:TextAlign.start,
      style: TextStyle(
          fontSize: 18.5,
          fontWeight: isbold?FontWeight.bold:FontWeight.normal,
          color: color,
          decoration: isUnderlined?TextDecoration.underline:TextDecoration.none,
          decorationColor: color,
          decorationThickness: 1
      ),
    );
  }
}

