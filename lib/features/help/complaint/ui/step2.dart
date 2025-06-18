
import 'dart:io';

import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
class Step2 extends StatelessWidget {
  final String subcategory;
  final ValueChanged<String?> onSubcategoryChange;
  final String description;
  final ValueChanged<String> onDescriptionChange;
  final XFile? pickedImage;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;

  const Step2({
    Key? key,
    required this.subcategory,
    required this.onSubcategoryChange,
    required this.description,
    required this.onDescriptionChange,
    required this.pickedImage,
    required this.onPickImage,
    required this.onRemoveImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNormalText(text: '2. Tell us more about the issue', color: Colors.black,size: 18,isbold: true,),
          const SizedBox(height: 12),

          CustomSubText(text: 'Subcategory', color: Colors.black),
          SizedBox(height: 8,),
          SubcategoryDropdown(
            subcategories: [
              'Internet disconnects frequently',
              'No connectivity',
              'Slow speed'
            ],
            hintText:
            subcategory.isEmpty ? 'Select Subcategory' : subcategory,
            onChanged: (val) => onSubcategoryChange(val),
          ),
          const SizedBox(height: 20),

          CustomSubText(text: 'Describe the Issue', color: Colors.black),
          SizedBox(height: 8,),
          TextFormField(
            initialValue: description,
            maxLength: 250,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Enter your issue here...',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
              counterText: '',
            ),
            onChanged: onDescriptionChange,
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: CustomSubText(text: 'max 250 Characters', color: primaryColor),
          ),
          const SizedBox(height: 12),

          CustomSubText(text: 'Attach Screenshot/Image', color: Colors.black),
          const SizedBox(height: 8),

          if (pickedImage == null)
            DottedBorder(
              dashPattern: const [6, 4],
              strokeWidth: 1,
              color: Colors.grey,
              child: InkWell(
                onTap: onPickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: const Color(0xFFF8F8F8),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_upload,
                          size: 24, color: Colors.grey[600]),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                text: 'Click here',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor)),
                            const TextSpan(
                                text: ' to upload or drop files here',
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Image.file(File(pickedImage!.path),
                      width: 60, height: 60, fit: BoxFit.cover),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(pickedImage!.name,
                          overflow: TextOverflow.ellipsis)),
                  IconButton(
                    icon:
                    Icon(Icons.close, color: Colors.grey[700]),
                    onPressed: onRemoveImage,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ===== Custom SubcategoryDropdown Widget =====

class SubcategoryDropdown extends StatefulWidget {
  final List<String> subcategories;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SubcategoryDropdown({
    Key? key,
    required this.subcategories,
    required this.onChanged,
    this.hintText = 'Select Subcategory',
  }) : super(key: key);

  @override
  _SubcategoryDropdownState createState() =>
      _SubcategoryDropdownState();
}

class _SubcategoryDropdownState extends State<SubcategoryDropdown> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openSearchDialog,
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          suffixIcon:
          const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ),
        isEmpty: _selected == null || _selected!.isEmpty,
        child: Text(
          _selected ?? '',
          style: TextStyle(
            color: _selected == null ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }

  Future<void> _openSearchDialog() async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        String query = '';
        List<String> filtered = widget.subcategories;

        return StatefulBuilder(
          builder: (context, setState) {
            void _updateFilter(String input) {
              setState(() {
                query = input;
                filtered = widget.subcategories
                    .where((s) => s
                    .toLowerCase()
                    .contains(query.trim().toLowerCase()))
                    .toList();
              });
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text('Choose Subcategory'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search…',
                        prefixIcon: Icon(Icons.search, color: Color(0xFF3A3C98)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3A3C98)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3A3C98)),
                        ),
                      ),
                      autofocus: true,
                      onChanged: _updateFilter,
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: filtered.isNotEmpty
                          ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: filtered.length,
                        itemBuilder: (context, i) {
                          final item = filtered[i];
                          return ListTile(
                            title: Text(item),
                            onTap: () => Navigator.pop(context, item),
                          );
                        },
                      )
                          : ListTile(
                        leading: const Icon(Icons.add),
                        title: Text('Create custom: "$query"'),
                        onTap: () => Navigator.pop(context, query.trim()),
                      ),
                    ),
                  ],
                ),
              ),
            );

          },
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      setState(() => _selected = result);
      widget.onChanged(result);
    }
  }
}
