import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomButton.dart';
import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/CommonWidgets/AppTextFormField.dart';
import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import '../../../routes/app_routes.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isObscured1 = true;
  bool _isObscured2 = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // back + logo
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, size: 30),
              onPressed: () => Get.back(),
              constraints:const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
            Image.asset(AppAssets.appLogo, width: 60, height: 60),
          ],
        ),

        const SizedBox(height: 40),
        const CustomBigHeadingText(
          text: 'Reset Password',
          color: primaryColor,
          isbold: true,
        ),
        const SizedBox(height: 10),
        const CustomSubText(
          text: 'Please type something you’ll remember',
          color: subtextColor,
        ),

        const SizedBox(height: 40),
        const CustomSubText(text: 'New Password', color: Colors.black),
        const SizedBox(height: 5),
        CustomTextFormField(
          hint: "Must be 8 characters",
          isPassword: _isObscured1,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() => _isObscured1 = !_isObscured1);
            },
            icon: Icon(
              _isObscured1 ? Icons.visibility : Icons.visibility_off,
              color: textboxColor,
            ),
          ),
          textEditingController: _passwordController,
          validator: (value) {
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
        const CustomSubText(text: 'Confirm Password', color: Colors.black),
        const SizedBox(height: 5),
        CustomTextFormField(
          hint: "Repeat Password",
          isPassword: _isObscured2,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() => _isObscured2 = !_isObscured2);
            },
            icon: Icon(
              _isObscured2 ? Icons.visibility : Icons.visibility_off,
              color: textboxColor,
            ),
          ),
          textEditingController: _confirmController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Confirm your password";
            }
            if (value != _passwordController.text) {
              return "Passwords do not match";
            }
            return null;
          },
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // A) Scrollable form area
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: _buildFormFields(),
                  ),
                ),
              ),

              // B) Full-width bottom button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  buttonName: 'Reset Password',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.toNamed(Routes.successfulpasswordreset);
                    }
                  },
                  isEnable: true,
                  isOutLine: false,
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomSubText(
                      text: 'Already have an account?',
                      color: subtextColor,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.login),
                      child: const CustomSubText(
                        text: ' Log in',
                        color: primaryColor,
                        isUnderlined: true,
                      ),
                    ),
                  ],
                ),
              ),
              // C) Extra padding so the button floats above the keyboard
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom > 0
                    ? MediaQuery.of(context).viewInsets.bottom
                    : 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
