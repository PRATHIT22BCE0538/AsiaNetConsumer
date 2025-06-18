// lib/Utility/common_widgets.dart
import 'package:flutter/material.dart';
import '../color_constants.dart';
import 'AppCustomText.dart';   // for CustomHeadingText, CustomNormalText, CustomSubText
import 'AppCustomButton.dart'; // for CustomButton

/// A row displaying a label and a copyable value
class AccountInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const AccountInfoRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomSubText(text: label, color: Colors.white),
        Row(
          children: [
            const Icon(Icons.copy, size: 16, color: Colors.white70),
            const SizedBox(width: 4),
            CustomNormalText(text: value, color: Colors.white, isbold: true,size: 16,),
          ],
        ),
      ],
    );
  }
}

/// A table of key/value rows inside a rounded container
class ServicePlanDetailsTable extends StatelessWidget {
  final Map<String, String> rows;
  const ServicePlanDetailsTable({Key? key, required this.rows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entries = rows.entries.toList();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(entries.length, (i) {
          final e = entries[i];
          return Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start, // top align for multiline
                  children: [
                    // Key/Label
                    Expanded(
                      flex: 2,
                      child: CustomSubText(
                        text: e.key,
                        color: subtextColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Value, right-aligned
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomNormalText(
                          text: e.value,
                          color: black,
                          isbold: true,
                          // size defaults to 18, alignment handled by Align
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (i < entries.length - 1)
                const Divider(height: 1, color: dividerColor),
            ],
          );
        }),
      ),
    );
  }
}

/// A card showing the active subscription
class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String typeLabel;
  final String period;
  final VoidCallback onViewMore;

  const SubscriptionCard({
    Key? key,
    required this.title,
    required this.price,
    required this.typeLabel,
    required this.period,
    required this.onViewMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title + price row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomNormalText(text: title, color: black, isbold: true),
              CustomNormalText(text: price, color: black, isbold: true),
            ],
          ),
          const SizedBox(height: 8),

          // subtitle row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomNormalText(
                      text: 'Recommended Type:', color: subtextColor, size: 16),
                  CustomNormalText(
                      text: typeLabel, color: black, isbold: true, size: 16),
                ],
              ),
              Flexible(
                  child: CustomNormalText(text: period, color: black, size: 12),
              )
            ],
          ),
          const SizedBox(height: 16),

          // view more button
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              buttonName: 'View More',
              iconEnable: true,
              iconAfter: true, // places icon after text
              iconData: Icons.arrow_forward,
              onPressed: onViewMore,
            ),
          ),
        ],
      ),
    );
  }
}

/// A card showing a suggestive additional pack
class SuggestivePackCard extends StatelessWidget {
  final String title;
  final String price;
  final String typeLabel;
  final String period;
  final VoidCallback onRemove;
  final VoidCallback onViewMore;

  const SuggestivePackCard({
    Key? key,
    required this.title,
    required this.price,
    required this.typeLabel,
    required this.period,
    required this.onRemove,
    required this.onViewMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title + price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomNormalText(text: title, color: black, isbold: true),
              CustomNormalText(text: price, color: black, isbold: true),
            ],
          ),
          const SizedBox(height: 8),

          // subtitle row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomNormalText(
                      text: 'Recommended Type:', color: subtextColor, size: 16),
                  CustomNormalText(
                      text: typeLabel, color: black, isbold: true, size: 16),
                ],
              ),
              Flexible(
                child: CustomNormalText(text: period, color: black, size: 12),
              )
            ],
          ),
          const SizedBox(height: 16),

          // action buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  buttonName: 'Remove',
                  iconEnable: true,
                  iconData: Icons.delete,
                  onPressed: onRemove,
                  isOutLine: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  buttonName: 'View More',
                  iconEnable: true,
                  iconAfter: true,
                  iconData: Icons.arrow_forward,
                  onPressed: onViewMore,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A small info block (2×2 grid) with title, value, and room for a corner image
class DetailBlock extends StatelessWidget {
  /// Block heading (e.g. “Amount Payable”)
  final String title;

  /// Block value (e.g. “Rs. 1234.56”)
  final String value;

  /// Path to the asset image to show in the top‑right corner
  final String assetPath;

  const DetailBlock({
    Key? key,
    required this.title,
    required this.value,
    required this.assetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
      child: Stack(
        children: [
          // Texts
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNormalText(text: title, color: subtextColor,size: 13.5,),
              const SizedBox(height: 8),
              CustomNormalText(text: value, color: black, isbold: true,size: 12,),
            ],
          ),

          // Corner image
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              assetPath,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
