// lib/features/login/ui/explorePlansPage.dart
import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:flutter/material.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
/// Simple model to tag each plan with one of our filter types
class Plan {
  final String priceText, sub1, sub2, buttonText, title, promoText;
  final List<String> benefits;
  /// 0 = all / show always,
  /// 1 = first filter (“Suggestive Plans”),
  /// 2 = second filter (“Broadband”),
  /// 3 = third filter (“A-La-Carte”)
  final int type;

  Plan({
    required this.priceText,
    required this.sub1,
    required this.sub2,
    required this.buttonText,
    required this.benefits,
    required this.promoText,
    this.title = '',
    required this.type,
  });
}

class explorePlansPage extends StatefulWidget {
  const explorePlansPage({super.key});

  @override
  State<explorePlansPage> createState() => _explorePlansPageState();
}

class _explorePlansPageState extends State<explorePlansPage> {
  final PageController _pageController = PageController(initialPage: 0);
  bool _showFilters = true;
  int _currentPage = 0;
  int _selectedIspFilterIndex = 0;
  int _selectedCatvFilterIndex = 0;

  final List<String> _ispFilters = [
    'All',
    'Unlimited Data',
    'Daily Data Limit',
    'High Speed 50+',
  ];
  final List<String> _catvFilters = [
    'All',
    'Suggestive Plans',
    'Broadband',
    'A-La-Carte',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTapToggle(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentPage = pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    final bool isIspPage = _currentPage == 0;
    final filters = isIspPage ? _ispFilters : _catvFilters;
    final selectedFilterIdx =
    isIspPage ? _selectedIspFilterIndex : _selectedCatvFilterIndex;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER + FILTER ICON
            Container(
              color: primaryColor,
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      CustomHeadingText(text: 'Explore Plans', color: Colors.white,isbold: true,),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() => _showFilters = !_showFilters);
                        },
                        child: Icon(
                          Icons.filter_list,
                          color:
                          _showFilters ? Colors.white : Colors.white70,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Segmented control
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        for (var i = 0; i < 2; i++)
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _onTapToggle(i),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: _currentPage == i
                                      ? Colors.white.withOpacity(0.25)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: CustomNormalText(text: i == 0 ? "ISP Plans" : "CATV Plans", color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // FILTER CHIPS
            if (_showFilters) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filters.length,
                  itemBuilder: (ctx, idx) {
                    final sel = idx == selectedFilterIdx;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: CustomNormalText(text: filters[idx], color: primaryColor,size: 14,),
                        selected: sel,
                        // sky-blue background when unselected
                        backgroundColor: bgColor,
                        // sky-blue background when selected (you can adjust if you want a different shade)
                        selectedColor: bgColor,
                        side: BorderSide(
                          color: sel ? Colors.transparent : Colors.grey.shade300,
                        ),
                        onSelected: (_) {
                          setState(() {
                            if (isIspPage) {
                              _selectedIspFilterIndex = idx;
                            } else {
                              _selectedCatvFilterIndex = idx;
                            }
                          });
                        },
                      ),

                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 12),
            // PAGEVIEW CONTENT
            Expanded(
              child: PageView(
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (p) => setState(() => _currentPage = p),
                children: [
                  _IspPlansPage(filterIndex: _selectedIspFilterIndex),
                  _CatvPlansPage(filterIndex: _selectedCatvFilterIndex),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ISP PLANS
class _IspPlansPage extends StatelessWidget {
  final int filterIndex;
  const _IspPlansPage({required this.filterIndex});

  List<Plan> get _recent => [
    Plan(
        priceText: "₹799",
        sub1: "100 mbps\ndata",
        sub2: "30 Days\nvalidity",
        buttonText: "Buy",
        benefits: [
          "High-speed fiber broadband",
          "Unlimited data usage",
          "Free Wi-Fi router (on 3-month plans)",
          "24×7 technical support",
        ],
        promoText: "Get ₹100 off on 6-month subscription!",
        type: 1),
  ];

  List<Plan> get _newlyAdded => [
    Plan(
        priceText: "₹499",
        sub1: "40 mbps\ndata",
        sub2: "30 Days\nvalidity",
        buttonText: "Buy",
        benefits: [
          "Ideal for browsing & video calls",
          "500GB high-speed data",
          "No installation charges",
          "Free modem (with 6-month plans)",
        ],
        promoText: "Recharge via app & get 10% cashback!",
        type: 2),
    Plan(
        priceText: "₹999",
        sub1: "150 mbps\ndata",
        sub2: "30 Days\nvalidity",
        buttonText: "Buy",
        benefits: [
          "Best for 4K streaming & gaming",
          "Truly unlimited data",
          "Free router + installation",
          "Priority customer support",
        ],
        promoText: "Get 1 month Amazon Prime free",
        type: 3),
  ];

  List<Plan> get _popular => [
    Plan(
        priceText: "₹1499",
        sub1: "300 mbps\ndata",
        sub2: "90 Days\nvalidity",
        buttonText: "Buy",
        benefits: [
          "Perfect for work-from-home setups",
          "2TB/month fair usage policy",
          "Free dual-band router",
          "Zero downtime promise",
        ],
        promoText: "₹200 OFF on annual renewal plans!",
        type: 3),
    Plan(
        priceText: "₹2199",
        sub1: "500 mbps\ndata",
        sub2: "90 Days\nvalidity",
        buttonText: "Buy",
        benefits: [
          "Ultra-fast for multi-device usage",
          "Unlimited downloads & uploads",
          "Free router + 24×7 on-site support",
          "1-year OTT bundle included",
        ],
        promoText: "Free Netflix + Hotstar + Zee5 access!",
        type: 1),
  ];

  @override
  Widget build(BuildContext context) {
    Widget section(String title, List<Plan> plans) {
      final filtered = (filterIndex == 0)
          ? plans
          : plans.where((p) => p.type == filterIndex).toList();
      if (filtered.isEmpty) return const SizedBox();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CustomNormalText(text: title, color: Colors.black,size: 16,),
          ),
          for (var p in filtered) ...[
            PlanCard(plan: p),
            const SizedBox(height: 16),
          ],
        ],
      );
    }

    return ListView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        section("Recent", _recent),
        section("Newly Added", _newlyAdded),
        section("Popular/Top Rated", _popular),
        const SizedBox(height: 24),
      ],
    );
  }
}

/// CATV PLANS
class _CatvPlansPage extends StatelessWidget {
  final int filterIndex;
  const _CatvPlansPage({required this.filterIndex});

  List<Plan> get _recent => [
    Plan(
        priceText: "₹199",
        sub1: "100+ Channels",
        sub2: "30 Days\nvalidity",
        buttonText: "Buy",
        title: "Kerala FTA-1",
        benefits: [
          "SD channels included",
          "Free installation",
          "10 popular regional channels",
          "Basic set-top box included",
        ],
        promoText: "Get ₹100 off on 6-month subscription!",
        type: 1),
  ];

  List<Plan> get _newlyAdded => [
    Plan(
        priceText: "₹299",
        sub1: "150+ Channels",
        sub2: "30 Days\nvalidity",
        buttonText: "Buy",
        title: "Kerala FTA-2",
        benefits: [
          "HD channels included",
          "No installation charges",
          "EPG guide access",
          "Basic remote included",
        ],
        promoText: "10% cashback on app recharge",
        type: 2),
    Plan(
        priceText: "₹399",
        sub1: "200+ Channels",
        sub2: "30 Days\nvalidity",
        buttonText: "Buy",
        title: "Kerala FTA-3",
        benefits: [
          "Local & regional channels",
          "Free on-site installation",
          "Multi-language support",
          "Basic set-top box included",
        ],
        promoText: "Free 1-month trial",
        type: 3),
  ];

  List<Plan> get _popular => [
    Plan(
        priceText: "₹499",
        sub1: "250+ Channels",
        sub2: "30 Days\nvalidity",
        buttonText: "Buy",
        title: "Kerala Premium",
        benefits: [
          "All SD & HD channels",
          "Digital set-top box",
          "EPG & parental lock",
          "Priority support",
        ],
        promoText: "₹100 OFF on first recharge",
        type: 2),
    Plan(
        priceText: "₹599",
        sub1: "300+ Channels",
        sub2: "30 Days\nvalidity",
        buttonText: "Buy",
        title: "Kerala Ultra",
        benefits: [
          "Includes sports & movie packs",
          "4K channel support",
          "Advanced DVR box",
          "24×7 customer care",
        ],
        promoText: "Free 2-month OTT bundle",
        type: 3),
  ];

  @override
  Widget build(BuildContext context) {
    Widget section(String title, List<Plan> plans) {
      final filtered = (filterIndex == 0)
          ? plans
          : plans.where((p) => p.type == filterIndex).toList();
      if (filtered.isEmpty) return const SizedBox();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CustomNormalText(text: title, color: Colors.black,size: 16,),
          ),
          for (var p in filtered) ...[
            PlanCard(plan: p),
            const SizedBox(height: 16),
          ],
        ],
      );
    }

    return ListView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        section("Recent", _recent),
        section("Newly Added", _newlyAdded),
        section("Popular/Top Rated", _popular),
        const SizedBox(height: 24),
      ],
    );
  }
}

/// PLAN CARD
class PlanCard extends StatelessWidget {
  final Plan plan;
  const PlanCard({required this.plan, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 4,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Row
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  CustomNormalText(text: plan.priceText, color: Colors.black,size: 24,),
                  const Spacer(),
                  CustomNormalText(text: plan.sub1, color: Colors.black,size: 11,),
                  const SizedBox(width: 16),
                  CustomNormalText(text: plan.sub2, color: Colors.black,size: 11,),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    child: Text(plan.buttonText),
                  ),
                ],
              ),
            ),

            // Optional Title
            if (plan.title.isNotEmpty)
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: CustomNormalText(text: plan.title, color: Colors.black,size: 16,),
              ),

            // Dotted Divider
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: LayoutBuilder(builder: (ctx, cons) {
                final dashW = 4.0, dashS = 4.0;
                final count = (cons.maxWidth / (dashW + dashS)).floor();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(count, (_) {
                    return Container(
                      width: dashW,
                      height: 1,
                      color: Colors.grey.shade300,
                    );
                  }),
                );
              }),
            ),

            // Benefits
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomNormalText(text: "Benefits", color: Colors.black,size: 16,),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: plan.benefits
                    .map((b) => Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 16),
                      const SizedBox(width: 8),
                      Expanded(child: Text(b)),
                    ],
                  ),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),

            // Promo Banner
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFE0F0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.local_offer,
                      color: secondaryColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                      child: CustomNormalText(text: plan.promoText, color: secondaryColor,size: 14,)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
