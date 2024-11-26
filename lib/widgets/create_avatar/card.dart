import 'dart:convert';

import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class AvatarCard extends StatefulWidget {
  const AvatarCard(
      {super.key,
      required this.title,
      this.isMalel = true,
      this.selected = false});
  final String title;
  final bool isMalel;
  final bool selected;
  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  Map<String, dynamic> getMap() {
    if (widget.isMalel) {
      return avatarsMap['noneChangedMale']!;
    } else {
      return avatarsMap['noneChangedFemale']!;
    }
  }

  String? avatarSvg;
  bool isLoading = true;
  late Map<String, dynamic> avatarMap;
  // Define your avatar map directly

  @override
  void initState() {
    super.initState();
    avatarMap = getMap();
    loadAvatar();
  }

  Future<void> loadAvatar() async {
    try {
      // Convert the avatar map to JSON and then decode it to SVG
      String avatarJson = json.encode(avatarMap);
      avatarSvg =
          await FluttermojiFunctions().decodeFluttermojifromString(avatarJson);

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 170.h,
      decoration: BoxDecoration(
        color: widget.selected
            ? OurColors.primaryColor.withOpacity(0.2)
            : OurColors.backgroundColor,
        border: Border.all(
          color: OurColors.primaryColor.withOpacity(0.4),
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: isLoading
                ? CircularProgressIndicator()
                : avatarSvg != null && avatarSvg!.isNotEmpty
                    ? SvgPicture.string(
                        avatarSvg!,
                        width: 100,
                        height: 100,
                        placeholderBuilder: (BuildContext context) =>
                            CircularProgressIndicator(),
                      )
                    : Text("Error loading"),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            widget.title,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
