import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomButton.dart';
import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utility/CommonWidgets/AppTextFormField.dart';
import '../../../routes/app_routes.dart';

class CreateAccount extends StatefulWidget {

  TextEditingController login = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  CreateAccount({super.key});


  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController password1 = TextEditingController();
  //checkbox
  bool _acceptedTerms = false;
  bool _isObscured=true;
  bool _isObscuredConfirm=true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        // Wrap in SingleChildScrollView to prevent overflow on smaller devices
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

                      // Top bar: back arrow + logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.chevron_left,
                              size: 30,
                            ),
                          ),
                          Image.asset(
                            AppAssets.appLogo,
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Title
                      CustomBigHeadingText(text: 'Create Account', color: primaryColor,isbold: true,),

                      const SizedBox(height: 40),

                      // Name label + field
                      CustomSubText(text: 'Name', color: Colors.black),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        hint: 'Your Name',
                        textEditingController: widget.name,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Name";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Login ID label + field
                      CustomSubText(text: 'Login ID', color: Colors.black),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        hint: 'Create Login',
                        textEditingController: widget.login,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Login Id";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Create a Password label + field
                      CustomSubText(text: 'Create a password', color: Colors.black),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        hint: "Must be 8 characters",
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
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Password";
                          }
                          if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },

                      ),

                      const SizedBox(height: 20),

                      // Confirm Password label + field
                      CustomSubText(text: 'Confirm Password', color: Colors.black),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        hint: "Repeat Password",
                        isPassword: _isObscuredConfirm,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscuredConfirm = !_isObscuredConfirm;
                            });
                          },
                          icon: Icon(
                            _isObscuredConfirm ? Icons.visibility : Icons.visibility_off,
                            color: textboxColor,
                          ),
                        ),
                        textEditingController: password1,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm your password";
                          }
                          if (value != password.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },

                      ),

                      const SizedBox(height: 20),

                      // Terms & Privacy checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _acceptedTerms,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _acceptedTerms = newValue ?? false;
                              });
                            },
                            activeColor: primaryColor,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _acceptedTerms = !_acceptedTerms;
                                });
                              },
                              child: CustomSubText(text: 'I accept the terms and privacy policy', color: Colors.black),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                    ],
                  ),
                ),
              ),
            ),
            // Sign up button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                buttonName: 'Sign up',
                onPressed: () {
                  if (!_acceptedTerms) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: CustomSubText(text: 'You must accept the terms and privacy policy.', color: Colors.white),
                      ),
                    );
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    Get.toNamed(Routes.login);
                  }
                },
                isEnable: true,
                isOutLine: false,
              ),
            ),

            // Already have an account? Log in
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomSubText(text: 'Already have an account? ', color: subtextColor),
                  GestureDetector(
                    onTap: () {
                      // Navigate to login screen
                      Get.toNamed(Routes.login);
                    },
                    child: CustomSubText(text: 'Log in', color: primaryColor,isUnderlined: true,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),

      ),
    );
  }
}
