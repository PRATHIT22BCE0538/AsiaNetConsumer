import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomButton.dart';
import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utility/constants.dart';
import '../../../routes/app_routes.dart';

class PasswordChanged extends StatefulWidget {
  const PasswordChanged({super.key});

  @override
  State<PasswordChanged> createState() => _PasswordChangedState();
}

class _PasswordChangedState extends State<PasswordChanged> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          // match the same horizontal padding you’ve been using
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            // center everything vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ==== Illustration ====
              //
              // Replace `AppAssets.passwordChangedIcon` with the
              // asset path / constant you have for the shield‐with‐check image.
              //
              // For example:
              //   AppAssets.passwordChangedIcon = 'assets/images/shield_check.png';
              //
              Spacer(),
              Image.asset(
                AppAssets.successfulTick,
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 40),

              // ==== “Password changed” Title ====
              const Text(
                "Password changed",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: primaryColor,
                  fontFamily: Constants.font
                ),
              ),

              const SizedBox(height: 8),

              // ==== Subtitle Text ====
              CustomSubText(text: 'Your password has been changed successfully', color: subtextColor,isCenter: true,),

              Spacer(),

              // ==== “Back to login” Button ====
              // Wrap in SizedBox to force full‐width
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  buttonName: 'Back to login',
                  // When pressed, send them back to the login route.
                  onPressed: () {
                    // Usually you’d want to clear the navigation stack:
                    Get.offAllNamed(Routes.login);
                  },
                  isEnable: true,
                  isOutLine: false,
                ),
              ),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
