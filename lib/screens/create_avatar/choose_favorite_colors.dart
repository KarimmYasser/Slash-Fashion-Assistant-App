import 'dart:convert';

import 'package:fashion_assistant/screens/create_avatar/get_preferences.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/create_avatar/choose_color_card.dart';
import 'package:fashion_assistant/widgets/create_avatar/color_circle.dart';
import 'package:fashion_assistant/widgets/create_avatar/question_pubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class ChooseFavColors extends StatefulWidget {
  const ChooseFavColors({
    super.key,
  });

  @override
  State<ChooseFavColors> createState() => _ChooseFavColorsState();
}

class _ChooseFavColorsState extends State<ChooseFavColors>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;

  Map<String, dynamic> getMap() {
    if (isMale) {
      return avatarsMap['male']!;
    } else {
      return avatarsMap['female']!;
    }
  }

  late Map<String, dynamic> avatarMap;

  @override
  void initState() {
    super.initState();
    avatarMap = getMap();
  }

  Future<String> loadAvatar() async {
    try {
      // Convert the avatar map to JSON, then decode it to SVG string
      String avatarJson = json.encode(avatarMap);
      return await FluttermojiFunctions()
          .decodeFluttermojifromString(avatarJson);
    } catch (error) {
      throw Exception("Error loading avatar SVG");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity, // Give the Row a defined width
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<String>(
                  future: loadAvatar(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error loading avatar");
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return SvgPicture.string(
                        snapshot.data!,
                        width: 80,
                        height: 80,
                        placeholderBuilder: (BuildContext context) =>
                            CircularProgressIndicator(),
                      );
                    } else {
                      return Text("Error loading avatar");
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 60.h),
                  child: SizedBox(
                    width: 240.w,
                    child: QuestionPubble(
                        message: 'What is your favorite colors?'),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Wrap(
            spacing: 20.w,
            runSpacing: 20.h,
            children: [
              _buildColorCircle(Color(0xff65C9FF), 'Blue'),
              _buildColorCircle(Color(0xff5099E4), 'Dark Blue'),
              _buildColorCircle(Color(0xffFFFFB1), 'Yellow'),
              _buildColorCircle(Color(0xffA7FFC4), 'Light Green'),
              _buildColorCircle(Color(0xff929598), 'Gray'),
              _buildColorCircle(Colors.black, 'Black'),
              _buildColorCircle(Color(0xff27557C), 'Navy'),
              _buildColorCircle(Color(0xffE6E6E6), 'Light Gray'),
              _buildColorCircle(Color(0xff3D4E5C), 'Dark Gray'),
              _buildColorCircle(Color(0xffFFDEB5), 'Peach'),
              _buildColorCircle(Color(0xffFFAFB9), 'Pink'),
              _buildColorCircle(Color(0xffFF488E), 'Hot Pink'),
              _buildColorCircle(Color(0xffFF5C5C), 'Red'),
              _buildColorCircle(Color.fromARGB(255, 252, 251, 251), 'White'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorCircle(Color color, String colorName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedColors.contains(colorName)) {
            selectedColors.remove(colorName);
          } else {
            selectedColors.add(colorName);
          }
        });
      },
      child: ColorCircle(
        color: color,
        isSelected: selectedColors.contains(colorName),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
