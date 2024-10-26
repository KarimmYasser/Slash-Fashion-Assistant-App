import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar(
      {super.key, required this.ontap, required this.activeScreen});
  final void Function(int) ontap;
  final int activeScreen;
  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  double icon_size = Sizes.iconLg;
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: widget.activeScreen,
      backgroundColor: OurColors.primaryButtonTextColor,
      buttonBackgroundColor: OurColors.primaryButtonBackgroundColor,
      color: OurColors.containerBackgroundColor,

      onTap: widget.ontap,
      items: [
        widget.activeScreen == 0
            ? Image.asset('assets/icons/homew.png',
                width: icon_size.w, height: icon_size.h)
            : Image.asset('assets/icons/home.png',
                width: icon_size.w, height: icon_size.h),
        widget.activeScreen == 1
            ? Image.asset('assets/icons/favoritew.png',
                width: icon_size.w, height: icon_size.h)
            : Image.asset('assets/icons/favorite.png',
                width: icon_size.w, height: icon_size.h),
        widget.activeScreen == 2
            ? Icon(
                FontAwesomeIcons.solidComment,
                color: OurColors.white,
              )
            : Icon(
                FontAwesomeIcons.comment,
                color: OurColors.iconPrimary,
              ),
        widget.activeScreen == 3
            ? Image.asset('assets/icons/cartw.png',
                width: icon_size.w, height: icon_size.h)
            : Image.asset('assets/icons/cart.png',
                width: icon_size.w, height: icon_size.h),
        widget.activeScreen == 4
            ? Image.asset('assets/icons/profilew.png',
                width: icon_size.w, height: icon_size.h)
            : Image.asset('assets/icons/profile.png',
                width: icon_size.w, height: icon_size.h),
      ],
      // Ensure all items are displayed
    );
  }
}
