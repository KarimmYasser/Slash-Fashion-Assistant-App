import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/home_screen.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CustomCarousalSliders extends StatefulWidget {
  const CustomCarousalSliders({super.key, required this.imagesPaths});
  final List<String> imagesPaths;

  @override
  State<CustomCarousalSliders> createState() => _CustomCarousalSlidersState();
}

class _CustomCarousalSlidersState extends State<CustomCarousalSliders> {
  bool isAutoPlayEnabled = true;
  int _activePage = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

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
                  items: widget.imagesPaths.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: 300.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                child: ImagePlaceholder(imagePath: imagePath)),
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
