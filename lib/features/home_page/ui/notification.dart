// notification_page.dart
import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:flutter/material.dart';

import '../../../Utility/color_constants.dart';

/// Enum to represent the available filter choices.
enum NotificationFilter { all, today, yesterday }

/// Maps enum values to human-readable strings.
String _filterToString(NotificationFilter filter) {
  switch (filter) {
    case NotificationFilter.today:
      return "Today";
    case NotificationFilter.yesterday:
      return "Yesterday";
    case NotificationFilter.all:
    default:
      return "All";
  }
}

/// A sample NotificationPage that allows filtering “Today” vs “Yesterday”
/// notifications. The featured purple card always stays visible.
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  /// Controls whether the purple “Featured Notification” is shown.
  bool _showFeatured = true;

  /// Which filter is currently active.
  NotificationFilter _selectedFilter = NotificationFilter.all;

  @override
  Widget build(BuildContext context) {
    // Convenience flags for showing sections
    final bool showToday = (_selectedFilter == NotificationFilter.all ||
        _selectedFilter == NotificationFilter.today);
    final bool showYesterday = (_selectedFilter == NotificationFilter.all ||
        _selectedFilter == NotificationFilter.yesterday);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── HEADER SECTION ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomHeadingText(text: 'Notifications', color: Colors.black,isbold: true,),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            children: [
                              const TextSpan(text: "You have "),
                              TextSpan(
                                text:
                                "${_filterToString(_selectedFilter)} Notifications",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFED008E),
                                ),
                              ),
                              const TextSpan(text: " in view."),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Filter button (round outline). Tapping shows a bottom sheet.
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.black54,
                      ),
                      onPressed: () => _showFilterOptions(context),
                    ),
                  ),
                ],
              ),
            ),

            // ── BODY LIST ───────────────────────────────────────────
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  // ── FEATURED NOTIFICATION WITH ANIMATION ───────────────
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: _showFeatured
                        ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Stack(
                        children: [
                          // Purple “New Features Just Launched!” container
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4B32C3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: const [
                                CustomNormalText(text: 'New Features Just Launched!', color: Colors.white,isbold: true,),
                                SizedBox(height: 8),
                                CustomNormalText(text: 'Explore faster speeds, better control, and new channel packs in your app.', color: Colors.white,size: 16,),
                              ],
                            ),
                          ),

                          // “X” close button in top-right corner
                          Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _showFeatured = false;
                                });
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.white70,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : const SizedBox.shrink(),
                  ),

                  // ── “Today” SECTION ───────────────────────────────────
                  if (showToday) ...[
                    _buildSectionTitle("Today"),

                    // 1) Renewal Reminder
                    ElevationOnTapNotificationCard(
                      iconData: Icons.notifications_none,
                      iconBgColor: Colors.blue,
                      title: "Renewal Reminder",
                      subtitle: "Your plan is expiring soon!",
                      timeAgo: "9 min ago",
                      badgeCount: 2,
                      badgeColor: const Color(0xFFED008E),
                    ),

                    // 2) Recharge Offer
                    ElevationOnTapNotificationCard(
                      iconData: Icons.notifications_none,
                      iconBgColor: Colors.amber.shade600,
                      title: "Recharge Offer",
                      subtitle: "Recharge now and get extra benefits",
                      timeAgo: "9 min ago",
                      badgeCount: 0,
                      badgeColor: const Color(0xFFED008E),
                    ),

                    // 3) Limited Time Offer
                    ElevationOnTapNotificationCard(
                      iconData: Icons.notifications_none,
                      iconBgColor: Colors.orange.shade600,
                      title: "Limited Time Offer",
                      subtitle:
                      "Exclusive offer: Get 10% off on your next recharge!",
                      timeAgo: "9 min ago",
                      badgeCount: 1,
                      badgeColor: const Color(0xFFED008E),
                    ),
                  ],
                  SizedBox(height: 10,),
                  // ── “Yesterday” SECTION ────────────────────────────────
                  if (showYesterday) ...[
                    _buildSectionTitle("Yesterday"),

                    // 4a) Channel Update
                    ElevationOnTapNotificationCard(
                      iconData: Icons.notifications_none,
                      iconBgColor: Colors.redAccent.shade400,
                      title: "Channel Update",
                      subtitle: "New channels added to your pack",
                      timeAgo: "9 min ago",
                      badgeCount: 0,
                      badgeColor: const Color(0xFFED008E),
                    ),

                    // 4b) Payment Confirmation
                    ElevationOnTapNotificationCard(
                      iconData: Icons.notifications_none,
                      iconBgColor: Colors.green.shade400,
                      title: "Payment Confirmation",
                      subtitle: "Payment successful for ₹500",
                      timeAgo: "9 min ago",
                      badgeCount: 3,
                      badgeColor: const Color(0xFFED008E),
                    ),
                  ],

                  const SizedBox(height: 24),
                ],
              ),
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
          CustomNormalText(text: title, color: Colors.black,isbold: true,size: 20,),
          const SizedBox(width: 10),
          const Expanded(
            child: Divider(
              color: dividerColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
  /// Displays a bottom sheet with the filter choices: All / Today / Yesterday.
  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // “All” option
            ListTile(
              title: Text(
                _filterToString(NotificationFilter.all),
                style: TextStyle(
                  fontWeight: _selectedFilter == NotificationFilter.all
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedFilter = NotificationFilter.all;
                });
                Navigator.pop(context);
              },
            ),

            // “Today” option
            ListTile(
              title: Text(
                _filterToString(NotificationFilter.today),
                style: TextStyle(
                  fontWeight: _selectedFilter == NotificationFilter.today
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedFilter = NotificationFilter.today;
                });
                Navigator.pop(context);
              },
            ),

            // “Yesterday” option
            ListTile(
              title: Text(
                _filterToString(NotificationFilter.yesterday),
                style: TextStyle(
                  fontWeight: _selectedFilter ==
                      NotificationFilter.yesterday
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedFilter = NotificationFilter.yesterday;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

/// A notification card that “lifts” (increases elevation) when tapped or hovered.
class ElevationOnTapNotificationCard extends StatefulWidget {
  final IconData iconData;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final String timeAgo;
  final int badgeCount;
  final Color badgeColor;

  const ElevationOnTapNotificationCard({
    required this.iconData,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.badgeCount,
    required this.badgeColor,
    super.key,
  });

  @override
  State<ElevationOnTapNotificationCard> createState() =>
      _ElevationOnTapNotificationCardState();
}

class _ElevationOnTapNotificationCardState
    extends State<ElevationOnTapNotificationCard> {
  bool _pressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _pressed = true);
  }

  void _onTapCancel() {
    setState(() => _pressed = false);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _pressed = false);
    // TODO: Handle actual tap action (e.g., navigate to detail page).
  }

  @override
  Widget build(BuildContext context) {
    // Animate between elevation 2 (normal) and 8 (pressed).
    final double elevation = _pressed ? 8 : 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedPhysicalModel(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          shape: BoxShape.rectangle,
          elevation: elevation,
          shadowColor: Colors.black45,
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: widget.iconBgColor.withOpacity(0.2),
                child: Icon(widget.iconData, color: widget.iconBgColor),
              ),
              title: CustomNormalText(text: widget.title, color: Colors.black,size: 18,isbold: true,),
              subtitle: CustomNormalText(text: widget.subtitle, color: subtextColor,size: 15,),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Timestamp
                  CustomNormalText(text: widget.timeAgo, color: subtextColor,size: 14,isbold: true,),
                  const SizedBox(height: 6),
                  // Optional badge if badgeCount > 0
                  if (widget.badgeCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: widget.badgeColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${widget.badgeCount}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
