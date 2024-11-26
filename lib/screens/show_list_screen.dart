import 'package:fashion_assistant/constants.dart';

import 'package:fashion_assistant/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ShowListScreen extends StatefulWidget {
  const ShowListScreen({super.key, required this.title});
  final String title;

  @override
  _ShowListScreenState createState() => _ShowListScreenState();
}

class _ShowListScreenState extends State<ShowListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 200) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.backgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // SliverAppBar to hold the title bar and make it scrollable
          SliverAppBar(
            backgroundColor: OurColors.backgroundColor,
            pinned: true,
            expandedHeight: 70.h,
            leading: IconButton(
              icon: const Icon(
                Iconsax.arrow_left,
                color: OurColors.grey,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.title,
                style: TextStyle(
                  color: OurColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              centerTitle: true,
            ),
          ),
          // Search Bar as a Sliver
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: OurColors.containerBackgroundColor,
                  borderRadius: BorderRadius.circular(50), // Circular shape
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Iconsax.search_favorite,
                        color: OurColors.primaryColor),
                    border: InputBorder.none, // Remove default border
                    enabledBorder: InputBorder.none, // Remove enabled border
                    focusedBorder: InputBorder.none, // Remove focused border
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14), // Center text
                  ),
                ),
              ),
            ),
          ),
          // List of Cards in a Scrollable SliverList
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const ProductCard(
                  brandImage:
                      'https://s3-alpha-sig.figma.com/img/709b/907e/4e3118132f60e1919c5891c6e22883fe?Expires=1731283200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qnF7TC5k8yOoJLEs4Ahuiip23Rr0BP3HMCK6U-fRo1nkRiQxaGks3iGPIXTKfduvmvGGcamJ9aKlccNZhnIEvvif2EFsIfgxAiW9kXLEFNyuKOuOoD9YwNRT91DbkkgNZuIZjsjdzhu1JS00bxn778jDGTBnJ3E50vnghuEW3xY1MWFb24-gy88W4ZePae22MM6CwltLndPFkdLziNow5F45jn4ObRhMifbTl5puhUBUDHaLb9xO8srJZS0vJxoOoNbiBz9YT9EK5IhLoFMqcJvd3si6-TVNcD-c75zQlCSuXURnGZ65dPBQVHRWtHSgCTebju1yvjiVaETxQPwtlw__',
                  brandName: 'Fashoni',
                  brandShowcase: '100% Natural Cotton Suit',
                  prevprice: 400,
                  price: '300',
                  discound: '20',
                  sold: '130',
                  numReviewers: '132',
                  stars: '5',
                  coin: 'EGP',
                );
              },
              childCount: 20, // Number of items in the list
            ),
          ),
        ],
      ),
      // Floating Action Button for Scroll-to-Top
      floatingActionButton: _showScrollToTopButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              shape: const CircleBorder(), // Ensure circular shape
              backgroundColor: OurColors.primaryColor,
              child: Icon(
                Iconsax.arrow_circle_up,
                color: Colors.white,
              ), // Optional color customization
            )
          : null,
    );
  }
}
