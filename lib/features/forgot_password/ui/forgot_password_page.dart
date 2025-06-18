import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utility/CommonWidgets/AppCustomButton.dart';
import '../../../Utility/CommonWidgets/AppTextFormField.dart';
import '../../../routes/app_routes.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.chevron_left,size: 30,fill: 1,), onPressed: () { Get.back(); },
                    constraints:const BoxConstraints(),
                    padding: EdgeInsets.zero,),
                  Image.asset(AppAssets.appLogo,width: 60,height: 60,)
                ],
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  CustomBigHeadingText(text: 'Forgot Password?', color: primaryColor,isbold: true,)
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Flexible(
                      child:CustomSubText(text: 'Don’t worry! It happens. Please enter the email associated with your account.', color: subtextColor)
                  )
                ],
              ),
              SizedBox(height: 20),
              CustomSubText(text: 'Email address', color: Colors.black),
              SizedBox(height: 5),
              CustomTextFormField(
                hint: 'Enter your email address',
                textEditingController: email,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email Id";
                  }
                  return null;
                },
              ),
              Spacer(),
              CustomButton(
                buttonName: 'Send Code',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // print("Login Done");

                    Get.toNamed(Routes.otp);
                  }
                },
                isEnable: true,
                isOutLine: false,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSubText(text: 'Remember Password? ', color: subtextColor),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(Routes.login);
                    },
                    child: CustomSubText(text: 'Log In', color: primaryColor,isUnderlined: true,),
                  )
                ],
              ),
              SizedBox(height: 20,)
            ],

          ),
        ),

      ),
    );
  }
}
