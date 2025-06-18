import 'dart:io';

import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
class Step3 extends StatelessWidget {
  final String serviceType;
  final String issueType;
  final String subcategory;
  final String description;
  final XFile? pickedImage;
  final VoidCallback onRemoveImage;

  const Step3({super.key, required this.serviceType, required this.issueType, required this.subcategory, required this.description, this.pickedImage, required this.onRemoveImage});
  // …

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF3A3C98);
    final greyBg = Colors.grey[200]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNormalText(text: '3. Review & Submit', color: Colors.black,isbold: true,size: 16,),
          const SizedBox(height: 12),

          // Service Type
          CustomNormalText(text: 'Service Type', color: Colors.black,size: 16,),
          const SizedBox(height: 4),
          TextField(
            readOnly: true,
            controller: TextEditingController(text: serviceType),
            decoration: InputDecoration(
              filled: true,
              fillColor: greyBg,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 12),

          // Issue Type
          CustomNormalText(text: 'Issue Type', color: Colors.black,size: 16,),
          const SizedBox(height: 4),
          TextField(
            readOnly: true,
            controller: TextEditingController(text: issueType),
            decoration: InputDecoration(
              filled: true,
              fillColor: greyBg,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 12),

          // Subcategory
          if (subcategory.isNotEmpty) ...[
            const CustomNormalText(text: 'Subcategory', color: Colors.black,size: 16,),
            const SizedBox(height: 4),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: subcategory),
              decoration: InputDecoration(
                filled: true,
                fillColor: greyBg,
                suffixIcon: const Icon(Icons.arrow_drop_down),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Description
          const CustomNormalText(text: 'Describe the Issue', color: Colors.black,size: 16,),
          const SizedBox(height: 4),
          TextField(
            readOnly: true,
            controller: TextEditingController(text: description),
            maxLines: 5,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomNormalText(text: 'max 250 Characters', color: primaryColor,size: 12,),
          ),
          const SizedBox(height: 12),

          // Attachment preview
          const CustomNormalText(text: 'Attach Screenshot/Image', color: Colors.black,size: 16,),
          const SizedBox(height: 8),
          if (pickedImage != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.file(File(pickedImage!.path), width: 24, height: 24, fit: BoxFit.cover),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(pickedImage!.name, style: const TextStyle(fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: 4),
                  const Text('•'),
                  const SizedBox(width: 4),
                  CustomNormalText(text: 'preview', color: primaryColor,size: 13,),
                  const Spacer(),
                  Text(
                    '${(File(pickedImage!.path).lengthSync() / (1024 * 1024)).toStringAsFixed(1)} MB',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onRemoveImage,
                    child: const Icon(Icons.close, size: 20, color: Colors.grey),
                  ),
                ],
              ),
            ),

        ],
      ),
    );
  }
}