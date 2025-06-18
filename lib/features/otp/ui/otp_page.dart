import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../Utility/CommonWidgets/AppCustomButton.dart';
import '../../../Utility/assets.dart';
import '../../../routes/app_routes.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OTPState();
}

class _OTPState extends State<OtpPage> {
  final TextEditingController _pinController = TextEditingController();
  final String validPinPattern = r'^\d{4}$';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left, size: 30, fill: 1),
                  onPressed: () {
                    Get.back();
                  },
                  constraints:const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
                Image.asset(AppAssets.appLogo, width: 60, height: 60),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Flexible(
                  child: CustomBigHeadingText(text: 'Please check your email', color: primaryColor,isbold: true,)
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Flexible(child:
                CustomSubText(text: 'We’ve sent a code to samplexyz@gmail.com', color: subtextColor))
              ],
            ),
            SizedBox(height: 40,),
            Form(
              key: _formKey,
              child: Pinput(
                controller: _pinController,
                length: 4,
                pinAnimationType: PinAnimationType.fade,
                separatorBuilder: (index)=>const SizedBox(width: 16,),
                defaultPinTheme: defaultPinTheme,
                validator: (value){
                  if(!RegExp(validPinPattern).hasMatch(value??'')){
                    return 'Enter a valid 4-digit code';
                  }
                  return null;
                },
              ),
            ),
            Spacer(),
            CustomButton(
              buttonName: 'Verify',
              onPressed: () {
                final pin = _pinController.text;
                if (_formKey.currentState!.validate() && RegExp(validPinPattern).hasMatch(pin)) {
                  Get.toNamed(Routes.resetpassword);
                }
              },
              isEnable: true,
              isOutLine: false,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSubText(text: 'Remember Password?', color: subtextColor),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.login);
                  },
                  child: CustomSubText(text: 'Log In', color: primaryColor,isUnderlined: true,),
                )
              ],
            ),
            SizedBox(height: 10,)
          ],

        ),
      ),
    );
  }
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color: Colors.black),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: textboxColor),
    ),
  );

}
