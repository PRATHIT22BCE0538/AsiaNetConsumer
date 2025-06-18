import 'package:flutter/material.dart';

import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../Utility/assets.dart';
import '../../../Utility/color_constants.dart';
import 'package:flutter_dash/flutter_dash.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  bool _showFilterChips = true;
  String _selectedFilter = "All";
  final List<String> _filters = ["All", "Success", "Pending", "Failed"];
  DateTime? _selectedDate;
  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  final List<Map<String, dynamic>> _allTransactions = [
    {
      "title": "Super Stream 100 mbps",
      "id": "ISP - TXN123456789",
      "amount": "Rs. 699",
      "dateTime": DateTime(2025, 6, 10, 12, 42, 36),
      "status": "Success",
    },
    {
      "title": "Basic 50 mbps",
      "id": "ISP - TXN790654",
      "amount": "Rs. 499",
      "dateTime": DateTime(2025, 6, 14, 11, 3, 16),
      "status": "Failed",
      "errorMsg": "Insufficient Balance",
    },
    {
      "title": "Premium 200 Mbps",
      "id": "ISP - TXN620487",
      "amount": "Rs. 1199",
      "dateTime": DateTime(2025, 5, 29, 8, 53, 40),
      "status": "Success",
    },
    {
      "title": "Postpaid Bill",
      "id": "TXN123456789",
      "amount": "Rs. 849",
      "dateTime": DateTime(2025, 5, 28, 12, 42, 36),
      "status": "Failed",
      "errorMsg": "Plan not available for this connection type",
    },
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    return _allTransactions.where((txn) {
      final matchesStatus = _selectedFilter == "All" || (txn["status"]?.toString().toLowerCase() == _selectedFilter.toLowerCase());
      final matchesDate = _selectedDate == null ||
          (txn["dateTime"] as DateTime).year == _selectedDate!.year &&
              (txn["dateTime"] as DateTime).month == _selectedDate!.month &&
              (txn["dateTime"] as DateTime).day == _selectedDate!.day;
      return matchesStatus && matchesDate;
    }).toList();
  }
  List<Map<String, dynamic>> get last7DaysTxns {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    return _filteredTransactions.where((txn) {
      final txnDate = txn["dateTime"] as DateTime;
      return txnDate.isAfter(sevenDaysAgo);
    }).toList();
  }

  List<Map<String, dynamic>> get lastMonthTxns {
    final now = DateTime.now();
    final startOfThisMonth = DateTime(now.year, now.month, 1);
    final startOfLastMonth = DateTime(now.year, now.month - 1, 1);
    return _filteredTransactions.where((txn) {
      final txnDate = txn["dateTime"] as DateTime;
      return txnDate.isAfter(startOfLastMonth) && txnDate.isBefore(startOfThisMonth);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildDateSelector(),
              const SizedBox(height: 16),
              _buildTabs(),
              const SizedBox(height: 12),
              _buildFilters(),
              const SizedBox(height: 12),

              Expanded(
                child: TabBarView(
                  children: [
                    ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        if (last7DaysTxns.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomNormalText(
                              text: "Last 7 Days",
                              color: Colors.black,
                              size: 16,
                              isbold: true,
                            ),
                          ),
                          ...last7DaysTxns.map((txn) => _buildTransactionCard(
                            title: txn["title"],
                            id: txn["id"],
                            amount: txn["amount"],
                            date: "${txn["dateTime"].day} ${_monthName(txn["dateTime"].month)} ${txn["dateTime"].year} | "
                                "${txn["dateTime"].hour.toString().padLeft(2, '0')}:${txn["dateTime"].minute.toString().padLeft(2, '0')}:${txn["dateTime"].second.toString().padLeft(2, '0')}",
                            status: txn["status"],
                            errorMsg: txn["errorMsg"],
                          )),
                        ],

                        if (lastMonthTxns.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomNormalText(
                              text: "Last Month",
                              color: Colors.black,
                              size: 16,
                              isbold: true,
                            ),
                          ),
                          ...lastMonthTxns.map((txn) => _buildTransactionCard(
                            title: txn["title"],
                            id: txn["id"],
                            amount: txn["amount"],
                            date: "${txn["dateTime"].day} ${_monthName(txn["dateTime"].month)} ${txn["dateTime"].year} | "
                                "${txn["dateTime"].hour.toString().padLeft(2, '0')}:${txn["dateTime"].minute.toString().padLeft(2, '0')}:${txn["dateTime"].second.toString().padLeft(2, '0')}",
                            status: txn["status"],
                            errorMsg: txn["errorMsg"],
                          )),
                        ],
                      ],
                    ),

                    Center(child: Text("No data yet", style: TextStyle(color: Colors.grey.shade400))),
                  ],
                ),
              ),
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
            CustomNormalText(text: 'Transaction History', color: Colors.black,size: 22,isbold: true,)
          ],
        ),
        InkWell(
          onTap: () {
            setState(() {
              _showFilterChips = !_showFilterChips;
            });
          },
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
  Widget _buildDateSelector() {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 18),
            const SizedBox(width: 8),
            CustomNormalText(
              text: _selectedDate != null
                ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                : "Select Date"
              , color: Colors.black,
              size: 14
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }


  Widget _buildTabs() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(12),
        ),
        tabs: const [
          Tab(text: "ISP"),
          Tab(text: "CATV"),
        ],
      ),
    );
  }
  Widget _buildFilters() {
    return _showFilterChips
        ? Wrap(
      spacing: 10,
      children: _filters.map((label) {
        return ChoiceChip(
          label: CustomNormalText(text: label, color: primaryColor,size: 16,),
          selected: _selectedFilter == label,
          selectedColor: Colors.indigo.shade100,
          backgroundColor: Colors.grey.shade300,
          onSelected: (isOn) {
            if (isOn) {
              setState(() => _selectedFilter = label);
            }
          },
        );
      }).toList(),
    )
        : const SizedBox.shrink();
  }



  Widget _buildTransactionCard({
    required String title,
    required String id,
    required String amount,
    required String date,
    required String status,
    String? errorMsg,
  }) {
    final bool isSuccess = status == "Success";
    final String iconAsset = isSuccess
        ? AppAssets.success
        : AppAssets.failed;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSuccess ? successBgColor : failedBgColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(iconAsset, width: 20, height: 20),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNormalText(text: title, color: Colors.black,size: 16,isbold: true,),
                    const SizedBox(height: 4),
                    CustomNormalText(text: id, color: subtextColor,size: 12,)
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomNormalText(text: amount, color: Colors.black,size: 16,isbold: true,),
                  const SizedBox(height: 4),
                  CustomNormalText(text: date, color: subtextColor,size: 12,)
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),


          LayoutBuilder(
            builder: (context, constraints) {
              return Dash(
                direction: Axis.horizontal,
                length: constraints.maxWidth,
                dashLength: 6,
                dashThickness: 1,
                dashColor: dividerColor,
              );
            },
          ),

          const SizedBox(height: 15),

          if (errorMsg != null)
            Row(
              children: [
                Expanded(
                  child: CustomNormalText(text: errorMsg, color: subtextColor,size: 13,)
                ),
                _StatusPill(isSuccess: isSuccess, label: status),
              ],
            )
          else
            Align(
              alignment: Alignment.centerRight,
              child: _StatusPill(isSuccess: isSuccess, label: status),
            ),
        ],
      ),
    );
  }

  Widget _StatusPill({required bool isSuccess, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSuccess ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomNormalText(text: label, color: isSuccess ? Colors.green : Colors.red,size: 12,)
    );
  }
}

