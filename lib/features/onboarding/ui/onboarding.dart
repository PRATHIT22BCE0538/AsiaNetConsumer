import 'dart:math' as math; // for rotating the ring
import 'package:asianetconsumer/Utility/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utility/color_constants.dart';
import '../../../routes/app_routes.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // Current page index (0, 1, or 2)
  int selectedIndex = 0;

  // Controller to swipe between pages
  final PageController _pageController = PageController(initialPage: 0);

  // Track previous and current ring-values for animation
  double _prevProgress = 0.0;
  double _currentProgress = 0.0;

  // Actual onboarding images (make sure these exist in pubspec.yaml)
  final List<String> _imagePaths = [
    AppAssets.onboarding1,
    AppAssets.onboarding2,
    AppAssets.onboarding3,
  ];

  // Titles for each page
  final List<String> _titles = [
    "Easy Recharges",
    "Track & Manage",
    "Offers & Support",
  ];

  // Subtitles / descriptions for each page
  final List<String> _subtitles = [
    "Recharge your broadband and cable in seconds—quick, safe, and anytime.",
    "Check balance, renew plans, and track usage with ease.",
    "Get exclusive deals and instant help whenever you need it.",
  ];

  // Primary accent color (your brand color)
  final Color _primaryColor = const Color(0xFF5E35B1); // deep indigo/purple

  // Inactive dot color
  final Color _inactiveDotColor = const Color(0xFFE0E0E0);

  // Pink arc color for the circular progress ring
  final Color _pinkRingColor = const Color(0xFFE91E63);

  @override
  void initState() {
    super.initState();
    // On first load, show 1/3 progress (page 0)
    _currentProgress = 1 / _imagePaths.length;
  }

  // Build a single pill/dot indicator for the bottom-left
  Widget _buildIndicatorDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? _primaryColor : _inactiveDotColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  // Generate pill/dot indicators based on how many pages we have
  List<Widget> _buildPageIndicator() {
    return List<Widget>.generate(
      _imagePaths.length,
          (index) => _buildIndicatorDot(index == selectedIndex),
    );
  }

  // Top bar: Back arrow (if not on first page) + “Skip”
  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
        child: Row(
          children: [
            if (selectedIndex > 0)
              GestureDetector(
                onTap: () {
                  if (selectedIndex > 0) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 22,
                ),
              )
            else
            // placeholder to align “Skip”
              const SizedBox(width: 22),

            const Spacer(),

            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.welcomepage);
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Compute progress (1/3, 2/3, 3/3) based on page index
  double _calculateProgress(int page) {
    return (page + 1) / _imagePaths.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1) Top bar
          _buildTopBar(),

          // 2) PageView for illustrations + text
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _imagePaths.length,
              onPageChanged: (int page) {
                setState(() {
                  _prevProgress = _currentProgress;
                  selectedIndex = page;
                  _currentProgress = _calculateProgress(page);
                });
              },
              itemBuilder: (_, index) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // Illustration
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            _imagePaths[index],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Title & Subtitle
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _titles[index],
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),

                          ),
                          const SizedBox(height: 12),
                          Text(
                            _subtitles[index],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 3) Bottom row: pill/dots on left + ring+button on right
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Row(
              children: [
                // (a) Pill/dots
                Row(children: _buildPageIndicator()),

                const Spacer(),

                // (b) Animated ring + inner button
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: _prevProgress,
                    end: _currentProgress,
                  ),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, animatedValue, _) {
                    return SizedBox(
                      height: 96, // Outer diameter for ring + padding
                      width: 96,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // 1) Padded & rotated ring
                          SizedBox(
                            height: 71,
                            width: 71,
                            child: Transform.rotate(
                              angle: math.pi, // Start at bottom
                              child: CircularProgressIndicator(
                                value: animatedValue,
                                strokeWidth: 4,
                                trackGap: 20,
                                strokeCap: StrokeCap.round,
                                color: _pinkRingColor,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),

                          // 2) “Next” button in center (36×36)
                          Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  if (selectedIndex < _imagePaths.length - 1) {
                                    _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    Get.toNamed(Routes.welcomepage);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
