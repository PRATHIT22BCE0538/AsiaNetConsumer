import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/assets.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:asianetconsumer/Utility/constants.dart';
import 'package:asianetconsumer/routes/app_routes.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Utility/CommonWidgets/AppCustomButton.dart';
import '../../../Utility/CommonWidgets/AppServiceIcons.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Page background color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Top Blue Header Section
          Container(
            color: primaryColor,
            padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
            child: Column(
              children: [
                // Top Row: Greetings and Wallet
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(text: 'Hello User,', color: Colors.white,isbold: true,size: 25,),
                        RichText(
                          text: TextSpan(
                            text: 'Welcome to ',
                            style: TextStyle(
                              fontSize: 15,
                              color: textboxColor,
                              fontFamily: Constants.font,
                              fontWeight: FontWeight.w700
                            ),
                            children: [
                              TextSpan(
                                text: 'Asianet',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: Constants.font
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.wallet,
                            height: 25,
                            width: 25,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CustomNormalText(text: 'Wallet Balance', color: Colors.white,size: 14),
                            SizedBox(height: 5),
                            CustomNormalText(text: '₹ 1550.00', color: Colors.white,isbold: true,size: 22,)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return _allSuggestions.where((s) =>
                          s.toLowerCase().contains(textEditingValue.text.toLowerCase())
                      );
                    },
                    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                      controller.text = _searchController.text;
                      controller.selection = _searchController.selection;
                      controller.addListener(() {
                        _searchController.value = controller.value;
                      });

                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onSubmitted: (_) => onFieldSubmitted(),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Image.asset(
                              AppAssets.search,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    },
                    onSelected: (selection) {
                      debugPrint('User selected: $selection');
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(8),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 200),
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: options.length,
                                separatorBuilder: (_, __) => const Divider(height: 1),
                                itemBuilder: (context, index) {
                                  final option = options.elementAt(index);
                                  return ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    title: Text(option),
                                    onTap: () => onSelected(option),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Rest of the body below header
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20,20,20,150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 CustomNormalText(text: 'Managed Services', color: Colors.black),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      // White card with rounded corners and subtle shadow
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: Column(
                        children: [
                          // ─── Row 1 of icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ServiceIconButton(
                                icon: AppAssets.bills,
                                label: "Bills", onTap: () { Get.toNamed(Routes.billDetails); },
                              ),
                              ServiceIconButton(
                                icon: AppAssets.recharge,
                                label: "Recharge", onTap: () { Get.toNamed(Routes.recharge); },
                              ),
                              ServiceIconButton(
                                icon: AppAssets.dataUsage,
                                label: "Data Usage", onTap: () { Get.toNamed(Routes.dataUsagePage); },
                              ),
                              ServiceIconButton(
                                icon: AppAssets.summery,
                                label: "Summary", onTap: () { Get.toNamed(Routes.usagesummery); },
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // ─── Row 2 of icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ServiceIconButton(
                                icon: AppAssets.help,
                                label: "Help", onTap: () {
                                Get.toNamed(Routes.help);
                              },

                              ),

                              ServiceIconButton(
                                icon: AppAssets.speedTest,
                                label: "Speed Test", onTap: (){Get.toNamed(Routes.speedTest);},
                              ),
                              ServiceIconButton(
                                icon: AppAssets.transaction,
                                label: "Transactions", onTap: () { Get.toNamed(Routes.transactionHistory); } ,
                              ),
                              // If you need a fourth icon here, add it. Otherwise, this SizedBox keeps spacing.
                              const SizedBox(width: 48),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){Get.toNamed(Routes.planDetails);},
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 1),
                          ),
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
                              SizedBox(width: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  CustomNormalText(text: 'Contract No.', color: Colors.white,size: 14,),
                                  SizedBox(width: 4),
                                  CustomNormalText(text: '1234567890', color: Colors.white,isbold: true,size: 16,)
                                ],
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            AppAssets.arrow,
                            height: 20,
                            width: 20,
                            color:
                                Colors
                                    .white, // if SVG uses currentColor, set this
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            CustomSubText(text: 'Current Plan', color: subtextColor),
                            GestureDetector(
                              onTap: (){Get.toNamed(Routes.planDetails);},
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  CustomNormalText(text: 'View Details', color: Colors.black,size: 14,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CustomNormalText(text: 'Speed Boost 999', color: Colors.black,size: 22,isbold: true,),
                        const SizedBox(height: 16),
                        const DottedLine(
                          dashColor: Colors.grey,
                          dashGapLength: 4,
                          dashLength: 6,
                          lineThickness: 1,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            _PlanInfoItem(title: "Rs. 999", subtitle: "Amount"),
                            SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                                width: 1,
                              ),
                            ),
                            _PlanInfoItem(title: "150", subtitle: "Channels"),
                            SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                                width: 1,
                              ),
                            ),
                            _PlanInfoItem(title: "ADD_ON", subtitle: "Type"),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Benefits
                        CustomNormalText(text: 'Benefits', color: Colors.black,size: 18,isbold: true,),
                        const SizedBox(height: 12),
                        const _BenefitItem(
                          text: "High-speed broadband up to 100 Mbps",
                        ),
                        const _BenefitItem(
                          text: "Unlimited downloads and uploads",
                        ),
                        const _BenefitItem(
                          text: "Access to premium OTT platforms",
                        ),
                        SizedBox(height: 20,),
                        CustomButton(
                          buttonName: "Explore more plans",
                          onPressed: () {
                            Get.toNamed(Routes.exploreplans);
                          },
                          isEnable: true,
                          isOutLine: false,
                          iconEnable: true,
                          customIcon: SvgPicture.asset(AppAssets.router),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allSuggestions = [
    "Bill Payment",
    "Recharge Plan",
    "Data Usage",
    "View Summary",
    "Speed Test",
    "Transaction History",
    "Support",
    // …add as many as you like
  ];
}

class _PlanInfoItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PlanInfoItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomNormalText(text: title, color: Colors.black,size: 16,isbold: true,),
        const SizedBox(height: 4),
        CustomNormalText(text: subtitle, color: subtextColor,size: 14,)
      ],
    );
  }

}

class _BenefitItem extends StatelessWidget {
  final String text;

  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
          SizedBox(width: 8),
          Expanded(child: CustomNormalText(text: text, color: Colors.black,size: 14,)),
        ],
      ),
    );
  }
}
