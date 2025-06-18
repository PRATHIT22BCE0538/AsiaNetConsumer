import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomButton.dart';
import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Utility/assets.dart';

class BillingHistory extends StatefulWidget {
  const BillingHistory({super.key});

  @override
  State<BillingHistory> createState() => _BillingHistoryState();
}

class _BillingHistoryState extends State<BillingHistory> {
  String? selectedYear;

  List<Map<String, dynamic>> get filteredData {
    if (selectedYear == null) return billingData;
    return billingData.where((item) => item['date'].contains(selectedYear!)).toList();
  }

  final List<Map<String, dynamic>> billingData = [
    {"date": "01 April 2025", "amount": "1234.56"},
    {"date": "01 March 2025", "amount": "2344.23"},
    {"date": "01 Feb 2025", "amount": "7982.00"},
    {"date": "01 Jan 2025", "amount": "3881.99"},
    {"date": "01 Dec 2024", "amount": "3637.83"},
    {"date": "01 Nov 2024", "amount": "3373.84"},
    {"date": "01 Oct 2024", "amount": "4636.52"},
    {"date": "01 Sep 2024", "amount": "6637.23"},
    {"date": "01 Aug 2024", "amount": "3233.42"},
    {"date": "01 July 2024", "amount": "3242.45"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 10),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTableHeader(),
              const SizedBox(height: 12),
              Expanded(child: _buildBillingList()),
              _buildViewMore(),
              const SizedBox(height: 20),
              CustomButton(buttonName: 'Download History', onPressed: (){}),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () => Navigator.of(context).pop(),
              padding: const EdgeInsets.only(right: 10),
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 10),
            CustomNormalText(text: 'Billing History', color: Colors.black,size: 22,isbold: true,)
          ],
        ),
        InkWell(
          onTap: _showFilterSheet,
          child: Container(
            height: 40,
            width: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4FC),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.filter_list, color: primaryColor),
          ),
        )

      ],
    );
  }

  Widget _buildTableHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CustomNormalText(text: 'Date', color: Colors.black,size: 16,isbold: true,),
          ),
          Expanded(
            flex: 3,
            child: CustomNormalText(text: 'Amount', color: Colors.black,size: 16,isbold: true,),
          ),
          Expanded(
            flex: 2,
            child: CustomNormalText(text: 'File', color: Colors.black,size: 16,isbold: true,),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingList() {
    final data = filteredData;

    if (data.isEmpty) {
      return const Center(child: Text("No billing records found."));
    }

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: data.length,
      separatorBuilder: (_, __) => const Divider(thickness: 0.6),
      itemBuilder: (context, index) {
        final item = data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomNormalText(text: item['date'], color: Colors.grey.shade700,size: 14,),
              ),
              Expanded(
                flex: 3,
                child: CustomNormalText(text: "Rs. ${item['amount']}", color: Colors.grey.shade700,size: 14,),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildMailIcon(AppAssets.mail),
                    const SizedBox(width: 8),
                    _buildDownloadIcon(AppAssets.download),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildMailIcon(String icon) {
    return Container(
      height: 32,
      width: 38,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 1.5),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(icon, color: primaryColor, fit: BoxFit.contain),
    );
  }

  Widget _buildDownloadIcon(String icon) {
    return Container(
      height: 32,
      width: 38,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(icon, color: Colors.white, fit: BoxFit.contain),
    );
  }

  Widget _buildViewMore() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("View More", style: TextStyle(fontSize: 14)),
          SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, size: 20),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    final years = billingData
        .map((e) => e['date'].split(' ').last) // Get year
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a)); // Descending

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Filter by Year",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...years.map((year) => ListTile(
                title: Text(year),
                trailing: selectedYear == year
                    ? const Icon(Icons.check, color: primaryColor)
                    : null,
                onTap: () {
                  setState(() {
                    selectedYear = year;
                  });
                  Navigator.pop(context);
                },
              )),
              if (selectedYear != null)
                ListTile(
                  title: const Text("Clear Filter"),
                  onTap: () {
                    setState(() {
                      selectedYear = null;
                    });
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

}
