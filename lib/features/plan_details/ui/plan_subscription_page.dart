// lib/features/plan_details/plan_subscription_page.dart
import 'package:flutter/material.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';

import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../Utility/CommonWidgets/common_widgets.dart';

class PlanSubscriptionPage extends StatelessWidget {
  const PlanSubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        // ─── Header Card ────────────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccountInfoRow(label: 'Contract No.', value: '123456789012'),
              const SizedBox(height: 8),
              AccountInfoRow(label: 'Account No.',  value: '00000000001040004154'),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: TextButton(
                  onPressed: () {
                    // TODO: switch account logic
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Switch Account',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )

            ],
          ),
        ),

        const SizedBox(height: 24),

        // ─── My Subscription ───────────────────────────────────────────────────
        CustomNormalText(
          text: 'My Subscription',
          color: black,
          isbold: true,
        ),
        const SizedBox(height: 8),
        SubscriptionCard(
          title: 'Base Pack(Base)',
          price: 'Rs. 599.00',
          typeLabel: 'GOVERNMENT',
          period: '01 May 2025 to 01 May 2026',
          onViewMore: () {
            // TODO: handle view more
          },
        ),

        const SizedBox(height: 24),

        // ─── Suggestive Packs ──────────────────────────────────────────────────
        CustomNormalText(
          text: 'Suggestive Packs',
          color: black,
          isbold: true,
        ),
        const SizedBox(height: 8),
        SuggestivePackCard(
          title: 'Complimentary FTA',
          price: 'Rs. 699.00',
          typeLabel: 'SUGGESTIVE',
          period: '01 May 2025 to 01 May 2026',
          onRemove: () {
            // TODO: handle remove
          },
          onViewMore: () {
            // TODO: handle view more
          },
        ),
        const SizedBox(height: 16),
        SuggestivePackCard(
          title: 'Complimentary FTA',
          price: 'Rs. 499.00',
          typeLabel: 'SUGGESTIVE',
          period: '01 April 2025 to 01 April 2026',
          onRemove: () {
            // TODO: handle remove
          },
          onViewMore: () {
            // TODO: handle view more
          },
        ),
      ],
    );
  }
}
