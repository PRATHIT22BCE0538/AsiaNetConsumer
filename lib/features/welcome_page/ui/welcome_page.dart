import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomButton.dart';
import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:asianetconsumer/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utility/assets.dart';
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.appLogo, width: 200, height: 200),
              ],
            ),
            Spacer(),
            CustomNormalText(text: "Your Broadband, Your Way", color: Colors.black,isbold: true,size: 30,isCenter: true,),
            SizedBox(height: 12,),
            CustomSubText(text: 'Manage your connection, view plans, and get support - all in one app.', color: subtextColor,isCenter: true,),
            Spacer(),
            CustomButton(
              buttonName: 'Log In',
              onPressed: (){
                Get.toNamed(Routes.login);
              },
              isEnable: true,),
            SizedBox(height: 20,),
            CustomButton(
              buttonName: 'Create Account',
              onPressed: (){
                Get.toNamed(Routes.signup);
              },
              isEnable: true,
            isOutLine: true,),
            Spacer()
          ],
        ),
      ),
    );
  }
}
