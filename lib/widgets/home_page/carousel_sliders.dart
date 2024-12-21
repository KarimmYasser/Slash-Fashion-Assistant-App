import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarousalSliders extends StatefulWidget {
  const CustomCarousalSliders({
    super.key,
    required this.offers,
  });
  final List<Map<String, dynamic>> offers;

  @override
  State<CustomCarousalSliders> createState() => _CustomCarousalSlidersState();
}

class _CustomCarousalSlidersState extends State<CustomCarousalSliders> {
  bool isAutoPlayEnabled = true;
  // ignore: unused_field
  int _activePage = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  void navigateToProductPage(BuildContext context, String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScreen(productID: productId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onLongPress: () {
            setState(() {
              isAutoPlayEnabled = false; // Stop sliding on long press
            });
          },
          onLongPressEnd: (_) {
            setState(() {
              isAutoPlayEnabled = true; // Resume sliding when long press ends
            });
          },
          onTap: () {},
          child: SizedBox(
              width: double.infinity,
              height: 140.h,
              child: CarouselSlider(
                  carouselController: _carouselController,
                  items: widget.offers.map((offer) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () => navigateToProductPage(
                              context, offer['product_id']),
                          child: Container(
                            width: 300.w,
                            decoration: BoxDecoration(
                              color: OurColors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  child: ImagePlaceholder(
                                      imagePath: offer['image'])),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 400.h,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: isAutoPlayEnabled,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _activePage = index;
                      });
                    },
                  ))),
        ),
        // Left circular button
        Positioned(
          left: 10.w,
          top: 0,
          bottom: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: OurColors.backgroundColor,
              ),
              child: IconButton(
                onPressed: () {
                  _carouselController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Image.asset(
                  'assets/icons/arrow_left.png',
                  scale: 2,
                ),
              ),
            ),
          ),
        ),

        // Right circular button
        Positioned(
          right: 10,
          top: 0,
          bottom: 0,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: OurColors.backgroundColor,
              ),
              child: IconButton(
                onPressed: () {
                  _carouselController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Image.asset(
                  'assets/icons/arrow_right.png',
                  scale: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      fit: BoxFit.cover,
    );
  }
}
