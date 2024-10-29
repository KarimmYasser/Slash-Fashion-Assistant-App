import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/home_page/product_card.dart';
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
              icon: Icon(
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
                child: TextField(
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
                return ProductCard(
                  brandShowcase: 'brandSHowcase',
                  description: 'description',
                  height: 400.h,
                  width: 600.h,
                  discount: '30',
                  price: '500',
                  coin: 'EGP',
                  image:
                      "https://media.istockphoto.com/id/1401899435/photo/image-of-young-asian-girl-posing-on-blue-background.jpg?s=2048x2048&w=is&k=20&c=PUMy-lxrA9ufa0_yjtk1_YEcj3bxd86fjD7_jCcTE3A=",
                  small: false,
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
              child: Icon(
                Iconsax.arrow_circle_up,
                color: Colors.white,
              ),
              shape: CircleBorder(), // Ensure circular shape
              backgroundColor:
                  OurColors.primaryColor, // Optional color customization
            )
          : null,
    );
  }
}
