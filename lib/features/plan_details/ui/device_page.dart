// lib/features/plan_details/device_page.dart
import 'package:flutter/material.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';


import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../Utility/CommonWidgets/common_widgets.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({Key? key}) : super(key: key);

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

        // ─── Service Plan Details ──────────────────────────────────────────────
        CustomNormalText(
          text: 'Service Plan Details',
          color: black,
          isbold: true,
        ),
        const SizedBox(height: 8),
        ServicePlanDetailsTable(
          rows: {
            'Device Condition': 'U',
            'Device Make': 'Genexis',
            'Device Model': 'ONT Genexis DB Wifi 11ac with 2 Gig port',
          },
        ),

        const SizedBox(height: 24),

        // ─── Device Details ────────────────────────────────────────────────────
        CustomNormalText(
          text: 'Device',
          color: black,
          isbold: true,
        ),
        const SizedBox(height: 8),
        ServicePlanDetailsTable(
          rows: {
            'Plan Name':      'DEVICE',
            'Plan Code':      'DEV',
            'Package Name':   'UNLOCK PACKAGE',
            'Package Code':   'UPKG',
            'Scheme Name':    'UNLOCK SCHEME',
            'Scheme Code':    'USCH',
            'Offer Duration': '1',
            'Promo':          'N/A',
            'Promo':          'N/A',
            'Promo Start Date': 'N/A',
          },
        ),
      ],
    );
  }
}
