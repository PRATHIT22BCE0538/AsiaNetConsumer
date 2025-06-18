import 'dart:math';

import 'package:asianetconsumer/routes/app_routes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utility/CommonWidgets/AppCustomText.dart';
import '../../../Utility/assets.dart';
import '../../../Utility/color_constants.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const Indicator({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, color: color),
        const SizedBox(width: 4),
        CustomNormalText(text: text, color: Colors.black),
      ],
    );
  }
}

class DataUsagePage extends StatefulWidget {
  const DataUsagePage({super.key});

  @override
  State<DataUsagePage> createState() => _DataUsagePageState();
}

class _DataUsagePageState extends State<DataUsagePage> {
  String? selectedRange;
  final List<String> dateOptions = ["7 Days", "15 Days", "30 Days", "Custom"];

  /// Hard‑coded sample data for fixed ranges
  final Map<String, List<Map<String, dynamic>>> allUsageData = {
    "7 Days": [
      {
        "date": "15 May",
        "download": 64.0,
        "upload": 42.0,
        "dateIso": "2025-05-15T00:00:00",
      },
      {
        "date": "14 May",
        "download": 70.0,
        "upload": 51.0,
        "dateIso": "2025-05-14T00:00:00",
      },
      {
        "date": "13 May",
        "download": 75.0,
        "upload": 60.0,
        "dateIso": "2025-05-13T00:00:00",
      },
      {
        "date": "12 May",
        "download": 69.0,
        "upload": 55.0,
        "dateIso": "2025-05-12T00:00:00",
      },
      {
        "date": "11 May",
        "download": 72.0,
        "upload": 47.0,
        "dateIso": "2025-05-11T00:00:00",
      },
      {
        "date": "10 May",
        "download": 65.0,
        "upload": 45.0,
        "dateIso": "2025-05-10T00:00:00",
      },
      {
        "date": "09 May",
        "download": 66.0,
        "upload": 43.0,
        "dateIso": "2025-05-09T00:00:00",
      },
    ],
    "15 Days": List.generate(15, (i) {
      final day = 15 - i;
      return {
        "date": "$day May",
        "download": (60 + (i * 2) % 10).toDouble(),
        "upload": (40 + (i * 3) % 10).toDouble(),
        "dateIso": DateTime(DateTime.now().year, 5, day).toIso8601String(),
      };
    }),
    "30 Days": List.generate(30, (i) {
      final day = 30 - i;
      return {
        "date": "$day May",
        "download": (50 + (i * 3) % 20).toDouble(),
        "upload": (30 + (i * 4) % 20).toDouble(),
        "dateIso": DateTime(DateTime.now().year, 5, day).toIso8601String(),
      };
    }),
  };

  List<Map<String, dynamic>> usageData = [];

  /// Handles chip taps, including custom date‑range via picker.
  Future<void> _onRangeSelected(String range) async {
    List<Map<String, dynamic>> raw;

    if (range == "7 Days") {
      raw = allUsageData["7 Days"]!;
    } else if (range == "15 Days") {
      raw = allUsageData["15 Days"]!;
    } else if (range == "30 Days") {
      raw = allUsageData["30 Days"]!;
    } else {
      final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now(),
      );
      if (picked == null) return;
      raw = _buildDummyCustomData(picked.start, picked.end);
    }

    // If more than 7 days, group into ~7 buckets
    if (raw.length > 7) {
      final bucketSize = (raw.length / 7).ceil();
      raw = _groupData(raw, bucketSize);
    }

    // Sort oldest→newest
    raw.sort(
      (a, b) =>
          DateTime.parse(a['dateIso']).compareTo(DateTime.parse(b['dateIso'])),
    );

    setState(() {
      selectedRange = range;
      usageData = raw;
    });
  }

  /// Creates dummy daily data between two dates.
  List<Map<String, dynamic>> _buildDummyCustomData(
    DateTime start,
    DateTime end,
  ) {
    final rnd = Random();
    final list = <Map<String, dynamic>>[];
    for (
      var dt = start;
      !dt.isAfter(end);
      dt = dt.add(const Duration(days: 1))
    ) {
      list.add({
        'date': "${dt.day.toString().padLeft(2, '0')} ${_monthName(dt.month)}",
        'dateIso': dt.toIso8601String(),
        'download': (20 + rnd.nextInt(80)).toDouble(),
        'upload': (10 + rnd.nextInt(50)).toDouble(),
      });
    }
    return list;
  }

  /// Groups raw daily entries into buckets of [groupSize].
  List<Map<String, dynamic>> _groupData(
    List<Map<String, dynamic>> rawData,
    int groupSize,
  ) {
    final grouped = <Map<String, dynamic>>[];
    for (var i = 0; i < rawData.length; i += groupSize) {
      final slice = rawData.sublist(
        i,
        (i + groupSize).clamp(0, rawData.length),
      );
      var dSum = 0.0, uSum = 0.0;
      for (var e in slice) {
        dSum += (e['download'] as num).toDouble();
        uSum += (e['upload'] as num).toDouble();
      }
      grouped.add({
        'date': "${slice.first['date']} - ${slice.last['date']}",
        'dateIso': slice.first['dateIso'],
        'download': dSum / slice.length,
        'upload': uSum / slice.length,
      });
    }
    return grouped;
  }

  String _monthName(int m) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: const EdgeInsets.only(right: 10),
                  constraints: const BoxConstraints(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomNormalText(
                      text: 'Data Usage',
                      color: Colors.black,
                      size: 22,
                      isbold: true,
                    ),
                    CustomNormalText(
                      text: 'Track & Manage your internet usage in real‑time.',
                      color: Colors.black,
                      size: 12,
                    ),
                  ],
                ),
              ],
            ),
            _buildHeader(),
            _buildDateSelectorChips(),
            const SizedBox(height: 16),
            if (selectedRange == null) ...[
              Image.asset(
                AppAssets.dataUsageBlank,
                height: 500,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 20),
              CustomNormalText(
                text: 'Please select a date range to view your data usage.',
                color: Colors.black,
                size: 22,
                isCenter: true,
              ),
            ] else ...[
              _buildChart(),
              const SizedBox(height: 16),
              _buildSectionTitle('Summary Panel'),
              _buildSummaryPanel(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return GestureDetector(
      onTap: (){Get.toNamed(Routes.planDetails);},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.list,
                  height: 25,
                  width: 25,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                const CustomNormalText(
                  text: 'Contract No. 1234567890',
                  color: Colors.white,
                  isbold: true,
                  size: 16,
                ),
              ],
            ),
            SvgPicture.asset(
              AppAssets.arrow,
              height: 20,
              width: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CustomNormalText(
            text: title,
            color: Colors.black,
            isbold: true,
            size: 16,
          ),
          const SizedBox(width: 10),
          const Expanded(child: Divider(color: dividerColor, thickness: 1)),
        ],
      ),
    );
  }

  Widget _buildDateSelectorChips() {
    return Wrap(
      spacing: 10,
      children:
          dateOptions.map((range) {
            final isSelected = selectedRange == range;
            return ChoiceChip(
              label: Text(range),
              selected: isSelected,
              onSelected: (_) => _onRangeSelected(range),
            );
          }).toList(),
    );
  }

  Widget _buildSummaryPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          usageData.map((data) {
            return ExpansionTile(
              iconColor: primaryColor,
              title: CustomNormalText(
                text: "CDR Date: ${data['date']}",
                color: Colors.grey.shade600,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                  child: CustomNormalText(
                    text:
                        "Download: ${data['download'].toStringAsFixed(1)} GB\nUpload: ${data['upload'].toStringAsFixed(1)} GB",
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNormalText(
          text: 'Usage Review in GB',
          color: Colors.black,
          isbold: true,
          size: 16,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: BarChart(
            BarChartData(
              maxY: 100,
              groupsSpace: 14,
              barGroups: [
                // Padding group at start
                BarChartGroupData(x: -2, barRods: []),
                ...usageData.asMap().entries.map((entry) {
                  int index = entry.key;
                  var data = entry.value;
                  return BarChartGroupData(
                    x: index * 2,
                    barsSpace: 6,
                    barRods: [
                      BarChartRodData(
                        toY: 100,
                        width: 12,
                        rodStackItems: [
                          BarChartRodStackItem(
                            0.0,
                            data['download'].toDouble(),
                            downloadBarColor,
                          ),
                          BarChartRodStackItem(
                            data['download'].toDouble(),
                            100.0,
                            Colors.indigo.shade100,
                          ),
                        ],
                        borderRadius: BorderRadius.zero,
                      ),
                      BarChartRodData(
                        toY: 100,
                        width: 12,
                        rodStackItems: [
                          BarChartRodStackItem(
                            0,
                            data['upload'],
                            uploadBarColor,
                          ),
                          BarChartRodStackItem(
                            data['upload'],
                            100,
                            Colors.orange.shade100,
                          ),
                        ],
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  );
                }).toList(),
                // Padding group at end
                BarChartGroupData(x: usageData.length * 2, barRods: []),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 20,
                    getTitlesWidget:
                        (value, meta) => CustomNormalText(
                          text: '${value.toInt()} GB',
                          color: Colors.grey.shade600,
                          size: 10,
                        ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      final idx = (value / 2).toInt();
                      if (idx < 0 || idx >= usageData.length)
                        return const SizedBox.shrink();

                      // e.g. “3 May - 1 May”
                      final fullLabel = usageData[idx]['date'] as String;
                      final parts = fullLabel.split(' - ');
                      final start = parts[0];
                      final end = parts.length > 1 ? parts[1] : '';

                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$start -',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              end,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: true,
                horizontalInterval: 20,
                verticalInterval: 2,
                getDrawingHorizontalLine:
                    (value) => FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                      dashArray: [2, 2],
                    ),
                getDrawingVerticalLine:
                    (value) => FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                      dashArray: [2, 2],
                    ),
              ),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Indicator(color: Colors.indigo, text: "Download"),
            SizedBox(width: 12),
            Indicator(color: Colors.orange, text: "Upload"),
          ],
        ),
      ],
    );
  }
}
