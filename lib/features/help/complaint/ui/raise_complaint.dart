// ===== Section 1: Imports and Main App Entry =====

import 'dart:io';
import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/features/help/complaint/ui/step1.dart';
import 'package:asianetconsumer/features/help/complaint/ui/step2.dart';
import 'package:asianetconsumer/features/help/complaint/ui/step3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import '../../../../Utility/CommonWidgets/AppCustomButton.dart';
import '../../../../routes/app_routes.dart';

// ===== Section 1.1: Main Application Entry Point =====

class ComplaintApp extends StatelessWidget {
  const ComplaintApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raise a Complaint',
      theme: ThemeData(
        primaryColor: const Color(0xFF3A3C98),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF3A3C98),
        ),
      ),
      home: const ComplaintPageView(),
    );
  }
}

// ===== Section 2: ComplaintPageView =====

class ComplaintPageView extends StatefulWidget {
  const ComplaintPageView({Key? key}) : super(key: key);

  @override
  _ComplaintPageViewState createState() => _ComplaintPageViewState();
}

class _ComplaintPageViewState extends State<ComplaintPageView> {
  final PageController _controller = PageController();
  int _currentStep = 0;

  String serviceType = 'Broadband';
  String issueType = 'Internet Not Working';
  String subcategory = '';
  String description = '';

  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? img = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (img != null) setState(() => _pickedImage = img);
  }

  void _removeImage() => setState(() => _pickedImage = null);

  void _next() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submit();
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _resetForm() {
    setState(() {
      serviceType = 'Broadband';
      issueType = 'Internet Not Working';
      subcategory = '';
      description = '';
      _pickedImage = null;
      _currentStep = 0;
    });
    _controller.jumpToPage(0);
  }

  void _submit() async {
    await Future.delayed(const Duration(milliseconds: 300));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SuccessDialog(
        ticketId: '#342189',
        onRaiseAnother: () {
          Navigator.of(context).pop();
          _resetForm();
        },
        onGoDashboard: () {
          Navigator.of(context).pop();
          Get.offAllNamed(Routes.homepage);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(), // remove default constraints
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 10),
                CustomNormalText(text: 'Raise a Complaint', color: Colors.black,size: 22,isbold: true,)
              ],
            ),
          ),
          StepIndicator(currentStep: _currentStep),
          Expanded(
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Step1(
                  selectedService: serviceType,
                  onServiceChange: (v) => setState(() => serviceType = v),
                  selectedIssue: issueType,
                  onIssueChange: (v) => setState(() => issueType = v),
                ),
                Step2(
                  subcategory: subcategory,
                  onSubcategoryChange: (v) => setState(() => subcategory = v ?? ''),
                  description: description,
                  onDescriptionChange: (v) => setState(() => description = v),
                  pickedImage: _pickedImage,
                  onPickImage: _pickImage,
                  onRemoveImage: _removeImage,
                ),
                Step3(
                  serviceType: serviceType,
                  issueType: issueType,
                  subcategory: subcategory,
                  description: description,
                  pickedImage: _pickedImage,
                  onRemoveImage: _removeImage,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: CustomButton(
                      buttonName: 'Back',
                      onPressed: _back,
                      isEnable: true,
                      isOutLine: true, // This makes it outlined
                    ),
                  ),

                if (_currentStep > 0) const SizedBox(width: 16),

                Expanded(
                  child: CustomButton(
                    buttonName: _currentStep < 2 ? 'Next' : 'Submit',
                    onPressed: _next,
                    isEnable: true, // Optional: defaults to true
                    isOutLine: false, // Optional: filled style
                    // No icon needed here, so iconEnable stays false (default)
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Section 3: StepIndicator =====
class StepIndicator extends StatelessWidget {
  final int currentStep;
  const StepIndicator({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = secondaryColor;

    // Total screen width minus horizontal padding (16 + 16)
    final totalWidth = MediaQuery.of(context).size.width - 32;

    // Each circle is 12px wide, and you have 3 of them = 36px
    // Remaining space is for the two connectors:
    final connectorWidth = (totalWidth - 36) / 2;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: List.generate(3, (i) {
              final filled = i <= currentStep;
              return Row(
                children: [
                  // Step circle
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: filled ? primary : Colors.grey[300],
                    ),
                  ),

                  // Connector line, only between circles
                  if (i < 2)
                    Container(
                      width: connectorWidth,
                      height: 2,
                      color: i < currentStep ? primary : Colors.grey[300],
                    ),
                ],
              );
            }),
          ),
          const SizedBox(height: 8),
          CustomSubText(
            text: 'Step ${currentStep + 1} of 3',
            color: subtextColor,
          ),
        ],
      ),
    );
  }
}


class SuccessDialog extends StatelessWidget {
  final String ticketId;
  final VoidCallback onRaiseAnother;
  final VoidCallback onGoDashboard;

  const SuccessDialog({
    Key? key,
    required this.ticketId,
    required this.onRaiseAnother,
    required this.onGoDashboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return AlertDialog(
      backgroundColor: Colors.white,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          Image.asset(
            AppAssets.success_tick,
            width: 64,
            height: 64,
          ),
          const SizedBox(height: 12),
          CustomNormalText(text: 'Success!', color: Colors.black),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: CustomNormalText(text: 'Your complaint has been submitted successfully!', color: Colors.black,isCenter: true,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomNormalText(text: 'Ticket ID: ', color: subtextColor),
                Text(ticketId,
                    style: const TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: ticketId));
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                            Text('Copied to clipboard')));
                  },
                  child: Icon(Icons.copy, size: 18, color: primaryColor),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: CustomNormalText(text: 'Our support team will contact you between 3 PM – 5 PM.', color: subtextColor,size: 14,isCenter: true,),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    buttonName: 'Track complaint',
                    onPressed: () {
                      Navigator.of(context).pop();
                      // TODO: Navigate to Track complaint screen
                    },
                    isEnable: true,
                    isOutLine: false, // Elevated style
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    buttonName: 'Raise Another Complaint',
                    onPressed: onRaiseAnother,
                    isEnable: true,
                    isOutLine: true, // Outlined style
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: onGoDashboard,
                  child: CustomNormalText(text: 'Go to Dashboard', color: primaryColor,size: 16,isUnderlined: true,),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Section 9: Utility Methods and Constants =====

// End of file.