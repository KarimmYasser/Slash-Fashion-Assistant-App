import 'dart:async';

import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  void stratTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (inHome & isAutoPlayEnabled) {
        setState(() {
          showDetails = false;
        });
        if (_pageController.page == widget.imagesPaths.length - 1) {
          _pageController.animateToPage(0,
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        } else {
          _pageController.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = List.generate(
        widget.imagesPaths.length,
        (index) => ImagePlaceholder(
              imagePath: widget.imagesPaths[index],
            ));
    if (inHome & isAutoPlayEnabled) stratTimer();
  }

  @override
  void dispose() {
    // Cancel the timer to avoid calling setState after widget disposal
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.imagesPaths.length,
              onPageChanged: (value) {
                setState(() {
                  _activePage = value;
                  showDetails = false;
                });
              },
              itemBuilder: (context, index) {
                return _pages[index];
              },
            ),
          ),
          if (showDetails)
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // Centered container with 80% of screen width
                padding: EdgeInsets.only(top: 90.h),
                decoration: BoxDecoration(
                  color: Colors.transparent, // Background with some opacity
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align items to the left
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'brandShowcase',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          '300 EGP',
                          style: TextStyle(
                              color: OurColors.primaryButtonBackgroundColor,
                              fontSize: 20.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'description',
                          style: TextStyle(
                            color: OurColors.secondaryTextColor,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '-30%',
                          style: TextStyle(
                              color: OurColors.secondaryColor, fontSize: 20.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: OurColors.primaryColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: const Text(
                        'Buy now',
                        style: TextStyle(
                          color: OurColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 10.sp,
            left: 0.sp,
            right: 0.sp,
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    _pages.length,
                    (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: InkWell(
                            onTap: () {
                              _pageController.animateToPage(index,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: _activePage == index
                                  ? OurColors.primaryColor
                                  : OurColors.grey,
                            ),
                          ),
                        )),
              ),
            ),
          ),
        ],
      ),
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
