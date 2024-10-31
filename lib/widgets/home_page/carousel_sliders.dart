import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/home_screen.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

late List<Widget> _pages;
int _activePage = 0;

Timer? _timer;
bool showDetails = false;
bool taped = false;

class CustomCarousalSliders extends StatefulWidget {
  const CustomCarousalSliders({super.key, required this.imagesPaths});
  final List<String> imagesPaths;

  @override
  State<CustomCarousalSliders> createState() => _CustomCarousalSlidersState();
}

class _CustomCarousalSlidersState extends State<CustomCarousalSliders> {
  final PageController _pageController = PageController(initialPage: 0);
  bool isAutoPlayEnabled = true;
  int _activePage = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  // void stratTimer() {
  //   _timer = Timer.periodic(Duration(seconds: 3), (timer) {
  //     if (inHome & isAutoPlayEnabled) {
  //       setState(() {
  //         showDetails = false;
  //       });
  //       if (_pageController.page == widget.imagesPaths.length - 1) {
  //         _pageController.animateToPage(0,
  //             duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  //       } else {
  //         _pageController.nextPage(
  //             duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _pages = List.generate(
        widget.imagesPaths.length,
        (index) => ImagePlaceholder(
              imagePath: widget.imagesPaths[index],
            ));
    //if (inHome & isAutoPlayEnabled) stratTimer();
  }

  // @override
  // void dispose() {
  //   // Cancel the timer to avoid calling setState after widget disposal
  //   _timer?.cancel();
  //   _pageController.dispose();
  //   super.dispose();
  // }

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
          onTap: () {
            setState(() {
              if (showDetails) {
                showDetails = false;
                isAutoPlayEnabled = true;
              } else {
                showDetails = true;
                isAutoPlayEnabled = false;
              }
            });
          },
          child: SizedBox(
              width: double.infinity,
              height: 140.h,
              child: CarouselSlider(
                  carouselController: _carouselController,
                  items: [0, 1, 2, 3, 4].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(
                              30.r), // Adjust this to control corner radius
                          child: Container(
                            color: OurColors.containerBackgroundColor,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            // Make sure height is enough to see the rounded corners
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: isAutoPlayEnabled,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
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
          left: 10,
          top: 0,
          bottom: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: OurColors.backgroundColor,
              ),
              child: IconButton(
                onPressed: () {
                  _carouselController.previousPage(
                    duration: Duration(milliseconds: 500),
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: OurColors.backgroundColor,
              ),
              child: IconButton(
                onPressed: () {
                  _carouselController.nextPage(
                    duration: Duration(milliseconds: 500),
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
