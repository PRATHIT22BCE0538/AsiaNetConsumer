import 'package:asianetconsumer/Utility/CommonWidgets/AppCustomText.dart';
import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:asianetconsumer/Utility/assets.dart';

import '../../../Utility/CommonWidgets/AppCustomButton.dart';

class CartItemData {
  final String imageAsset;
  final String title;
  final String type;
  final String quality;
  final double price;
  String duration;
  bool isSelected;

  CartItemData({
    required this.imageAsset,
    required this.title,
    required this.type,
    required this.quality,
    required this.price,
    this.duration = 'Duration',
    this.isSelected = false,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isSelecting = false;

  final List<CartItemData> _cartItems = [
    CartItemData(
      imageAsset: AppAssets.sonySab,
      title: "Sony SAB",
      type: "Entertainment",
      quality: "HD",
      price: 12.0,
    ),
    CartItemData(
      imageAsset: AppAssets.colors,
      title: "Colors",
      type: "Entertainment",
      quality: "HD",
      price: 12.0,
    ),
    CartItemData(
      imageAsset: AppAssets.indiaToday,
      title: "News 18 INDIA",
      type: "News",
      quality: "HD",
      price: 8.0, // will display as “08/month”
    ),
    CartItemData(
      imageAsset: AppAssets.discovery,
      title: "Discovery",
      type: "Entertainment",
      quality: "HD",
      price: 15.0,
    ),
  ];

  int _monthsFrom(String duration) {
    if (duration == 'Duration') return 0;
    final parts = duration.split(' ');
    if (parts.isEmpty) return 0;
    return int.tryParse(parts[0]) ?? 0;
  }

  double get _cartTotal {
    double total = 0.0;
    for (var item in _cartItems) {
      final months = _monthsFrom(item.duration);
      total += item.price * months;
    }
    return total;
  }

  // Remove a single item at [index].
  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  // Show a popup summarizing each item’s total (price×months) + the subtotal.
  void _showTotalSummary() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Total Summary"),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // List each item’s title and its total cost
                ..._cartItems.map((item) {
                  final months = _monthsFrom(item.duration);
                  final itemCost = item.price * months;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${item.title} (${months}m)",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          "₹${itemCost.toStringAsFixed(0)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }),
                const Divider(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Subtotal:",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹${_cartTotal.toStringAsFixed(0)}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("CLOSE"),
            )
          ],
        );
      },
    );
  }

  /// Helper to determine if all items are currently selected.
  bool get _allItemsSelected =>
      _cartItems.isNotEmpty && _cartItems.every((item) => item.isSelected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ─── HEADER ───────────────────────────────────────────────────────────
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                children: [
                  CustomHeadingText(text: "My Cart", color: Colors.black,isbold: true,),
                  const SizedBox(width: 8),

                  // Shopping-cart icon with dynamic badge:
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 28,
                        color: Colors.grey.shade700,
                      ),

                      // Only show badge if there is at least 1 item
                      if (_cartItems.isNotEmpty)
                        Positioned(
                          right: -6,
                          top: -6,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              _cartItems.length.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const Spacer(),

                  /// ─── SELECTION MODE BUTTONS ────────────────────────────────
                  if (!_isSelecting)
                  // When not in selection mode, show a single “Select” button
                    TextButton(
                      onPressed: () => setState(() {
                        _isSelecting = true;
                      }),
                      child: CustomNormalText(text: 'Select', color: primaryColor,size: 16,),
                    )
                  else
                  // When in selection mode, show “Select All / Deselect All” + “Cancel”
                    Row(
                      children: [
                        // 1) Select All / Deselect All
                        TextButton(
                          onPressed: () {
                            setState(() {
                              // If all are already selected, then deselect them.
                              // Otherwise, select them all.
                              final bool currentlyAll = _allItemsSelected;
                              for (var item in _cartItems) {
                                item.isSelected = !currentlyAll;
                              }
                            });
                          },
                          child: CustomNormalText(text: _allItemsSelected ? "Deselect All" : "Select All", color: primaryColor,size: 16,)
                        ),

                        const SizedBox(width: 8),

                        // 2) Cancel (exit selection mode & clear selections)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isSelecting = false;
                              // Clear all selections when exiting selection mode
                              for (var item in _cartItems) {
                                item.isSelected = false;
                              }
                            });
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const Divider(height: 1),

            // ─── LIST OF ITEMS ─────────────────────────────────────────────────────
            Expanded(
              child: _cartItems.isEmpty
                  ? const Center(
                child: Text(
                  "Your cart is empty.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  final item = _cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Row(
                          children: [
                            // ─── (1) Checkbox (if in selection mode) ─────────────
                            if (_isSelecting)
                              Checkbox(
                                value: item.isSelected,
                                onChanged: (bool? selected) {
                                  setState(() {
                                    item.isSelected = selected ?? false;
                                  });
                                },
                                side: BorderSide(
                                  color: primaryColor,
                                  width: 2
                                ),
                                activeColor: primaryColor,
                              ),

                            // ─── (2) Channel Logo ─────────────────────────────
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade100,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset(
                                  item.imageAsset,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // ─── (3) Text Column (title / type•quality / price) ─
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  CustomNormalText(text: item.title, color:Colors.black, isbold: true,),
                                  const SizedBox(height: 4),
                                  CustomNormalText(text: '${item.type} \nQuality: ${item.quality}', color: subtextColor,size: 14),
                                  const SizedBox(height: 8),
                                  // SHOW monthly price with leading zero if < 10
                                  CustomNormalText(text: 'Rs. ${item.price.toStringAsFixed(0).padLeft(2, '0')}/month', color: Colors.black,size: 16,),
                                ],
                              ),
                            ),

                            // ─── (4) Right Side: Duration dropdown & delete icon ─
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Duration DropdownButton
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade400),
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  child: DropdownButton<String>(
                                    value: item.duration,
                                    underline: const SizedBox(),
                                    items: const [
                                      DropdownMenuItem(
                                        value: "Duration",
                                        child: Text(
                                          "Duration",
                                          style: TextStyle(
                                              color: Colors.pink),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                          value: "1 month",
                                          child: Text("1 month")),
                                      DropdownMenuItem(
                                          value: "3 months",
                                          child: Text("3 months")),
                                      DropdownMenuItem(
                                          value: "6 months",
                                          child: Text("6 months")),
                                      DropdownMenuItem(
                                          value: "12 months",
                                          child: Text("12 months")),
                                    ],
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          item.duration = newValue;
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.expand_more,
                                      size: 20,
                                      color: Colors.pink,
                                    ),
                                    isDense: true,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Delete Icon (tap to remove item)
                                GestureDetector(
                                  onTap: () => _removeItem(index),
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        AppAssets.delete,
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  CustomButton(
                    buttonName: "View Total Summary",
                    onPressed: _cartItems.isEmpty ? null : _showTotalSummary,
                    isOutLine: true,
                    iconEnable: true,
                    iconData: Icons.receipt_long,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    buttonName: _cartItems.isEmpty
                        ? "Pay ₹0"
                        : "Pay Rs. ${_cartTotal.toStringAsFixed(0)}",
                    onPressed: _cartItems.isEmpty
                        ? null
                        : () {},
                    isEnable: _cartItems.isNotEmpty,
                    isOutLine: false,
                    iconEnable: true,
                    iconData: Icons.payment,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
