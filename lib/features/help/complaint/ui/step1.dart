import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Step1 extends StatelessWidget {
  final String selectedService;
  final ValueChanged<String> onServiceChange;
  final String selectedIssue;
  final ValueChanged<String> onIssueChange;

  const Step1({Key? key, required this.selectedService, required this.onServiceChange, required this.selectedIssue, required this.onIssueChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF3A3C98);
    // Compute cardWidth so two cards per row with padding and spacing:
    final screenWidth = MediaQuery.of(context).size.width;
    // Assuming padding 16 left/right and spacing 12 between: total 16+16+12 = 44
    // Use (screenWidth - 44)/2. Using 48 here as approximate; adjust for exact spacing.
    final cardWidth = (screenWidth - 48) / 2;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== 4.2: Service Type Toggle =====
          CustomNormalText(text: 'Select your service type to proceed:', color: Colors.black,size: 16,isbold: true,),
          const SizedBox(height: 8),
          Row(
            children: ['Digital TV', 'Broadband'].map((type) {
              final isSel = selectedService == type;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onServiceChange(type),
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.only(right: type == 'Digital TV' ? 8 : 0),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSel ? primary : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: isSel
                          ? null
                          : Border.all(color: Colors.black, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isSel ? Icons.check_circle : Icons.radio_button_unchecked,
                          size: 20,
                          color: isSel ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 8),
                        CustomNormalText(text: type, color: isSel ? Colors.white : Colors.black,size: 16,isbold: true,),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // ===== 4.3: Issue Type Cards =====
          CustomNormalText(text: '1. Issue Type (Choose One)', color: Colors.black,size: 16,isbold: true,),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _IssueCard(
                iconData: Icons.wifi_off,
                label: 'Internet Not Working',
                selected: selectedIssue == 'Internet Not Working',
                onTap: onIssueChange,
                width: cardWidth,
              ),
              _IssueCard(
                iconData: Icons.speed,
                label: 'Slow Internet Speed',
                selected: selectedIssue == 'Slow Internet Speed',
                onTap: onIssueChange,
                width: cardWidth,
              ),
              _IssueCard(
                iconData: Icons.receipt,
                label: 'Billing issue',
                selected: selectedIssue == 'Billing issue',
                onTap: onIssueChange,
                width: cardWidth,
              ),
              _IssueCard(
                iconData: Icons.router,
                label: 'Router/Modem Problem',
                selected: selectedIssue == 'Router/Modem Problem',
                onTap: onIssueChange,
                width: cardWidth,
              ),
              _IssueCard(
                iconData: Icons.add_ic_call,
                label: 'New Connection/ Relocation',
                selected: selectedIssue == 'New Connection/ Relocation',
                onTap: onIssueChange,
                width: cardWidth,
              ),
              _IssueCard(
                iconData: Icons.more_horiz,
                label: 'Other Issue',
                selected: selectedIssue == 'Other Issue',
                onTap: onIssueChange,
                width: cardWidth,
              ),
            ],
          ),
        ],
      ),
    );
  }

}
class _IssueCard extends StatelessWidget {
  final IconData iconData;
  final String label;
  final bool selected;
  final ValueChanged<String> onTap;
  final double width;

  const _IssueCard({Key? key, required this.iconData, required this.label, required this.selected, required this.onTap, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? primaryColor : Colors.grey[300]!;
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        width: width,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? primaryColor : Colors.white,
          border: Border.all(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Icon & Label positioned top-left
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  iconData,
                  size: 24,
                  color: selected ? Colors.white : Colors.black,
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: CustomNormalText(text: label, color: selected ? Colors.white : Colors.black,size: 14,isbold: true,)
                ),
              ],
            ),
            // Selection indicator at top-right
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? Colors.white : Colors.transparent,
                  border: Border.all(color: selected ? Colors.white : primaryColor, width: 1.5),
                ),
                child: selected
                    ? Icon(
                  Icons.check,
                  size: 14,
                  color: primaryColor,
                )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}