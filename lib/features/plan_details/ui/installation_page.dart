// lib/features/plan_details/installation_page.dart
import 'package:flutter/material.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';


import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../Utility/CommonWidgets/common_widgets.dart';

class InstallationPage extends StatelessWidget {
  const InstallationPage({Key? key}) : super(key: key);

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
              // Contract & Account rows
              AccountInfoRow(label: 'Contract No.', value: '123456789012'),
              const SizedBox(height: 8),
              AccountInfoRow(label: 'Account No.',  value: '00000000001040004154'),
              const SizedBox(height: 16),
              // Switch button
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
        ServicePlanDetailsTable(rows: {
          'MAC ID':              '30_CN250256_AA',
          'Serial No':           'gnxs.8370.2177',
          'Band Type':           'DB',
          'Technology Type':     'GPON',
          'Technically Active':  'YES',
          'Status':              'Locked',
          'Lock Reason':         'Payment Due',
          'Lock Date':           '2025-03-30',
        }),

        const SizedBox(height: 24),

        // ─── Installation Details ──────────────────────────────────────────────
        CustomNormalText(
          text: 'Installation',
          color: black,
          isbold: true,
        ),
        const SizedBox(height: 8),
        ServicePlanDetailsTable(rows: {
          'Plan Name':      'INSTALLATION',
          'Plan Code':      'INST',
          'Package Name':   'FAST PACKAGE',
          'Package Code':   'FAST_PKG',
          'Scheme Code':    'FAST_SCHEME',
          'Offer Duration': 'FAST_SCH',
        }),
      ],
    );
  }
}
