import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomButton.dart';
import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:asianetconsumer/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utility/CommonWidgets/AppTextFormField.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscured = true;
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left, size: 30),
                            onPressed: () => Get.back(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            visualDensity: VisualDensity.compact, // Optional: reduces tap padding
                          ),
                          Image.asset(AppAssets.appLogo, width: 60, height: 60),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          CustomBigHeadingText(text: 'Hi, Welcome!', color: primaryColor,isbold: true,),
                          const SizedBox(width: 10),
                          Image.asset(AppAssets.helloIcon,fit: BoxFit.fill,height: 40,width: 40,),
                        ],
                      ),
                      const SizedBox(height: 40),
                      CustomSubText(text: 'Login ID', color: Colors.black),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        hint: 'Your Login',
                        textEditingController: login,
                        validator: (value) =>
                        value == null || value.isEmpty ? "Enter Email Id" : null,
                      ),
                      const SizedBox(height: 20),
                      CustomSubText(text: 'Password', color: Colors.black),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        hint: "Password",
                        isPassword: _isObscured,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          icon: Icon(
                            _isObscured ? Icons.visibility : Icons.visibility_off,
                            color: textboxColor,
                          ),
                        ),
                        textEditingController: password,
                        validator: (value) =>
                        value == null || value.isEmpty ? "Enter Password" : null,
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Checkbox(
                                  side: const BorderSide(color: primaryColor, width: 2),
                                  activeColor: primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 4),
                              const CustomSubText(text: 'Remember me', color: Colors.black),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.forgotpassword),
                            child: CustomSubText(text: 'Forgot Password?', color: primaryColor),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              child: CustomButton(
                buttonName: 'Log in',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.toNamed(Routes.homepage);
                  }
                },
                isEnable: true,
                isOutLine: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
