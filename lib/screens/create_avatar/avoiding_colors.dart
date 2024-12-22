import 'dart:convert';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:http/http.dart' as http;
import 'package:fashion_assistant/screens/create_avatar/get_preferences.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fashion_assistant/widgets/create_avatar/color_circle.dart';
import 'package:fashion_assistant/widgets/create_avatar/question_pubble.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class AvoidingColors extends StatefulWidget {
  const AvoidingColors({super.key});

  @override
  State<AvoidingColors> createState() => _AvoidingColorsState();
}

class _AvoidingColorsState extends State<AvoidingColors>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  List<Map<String, dynamic>> colors = [];

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
    fetchColors();
  }

  Future<void> fetchColors() async {
    final response = await HttpHelper.get('api/constants/colours');

    setState(() {
      colors = List<Map<String, dynamic>>.from(response['colours']);
      isLoading = false;
    });
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70.h,
            ),
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
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
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
                      width: 220.w,
                      child: QuestionPubble(
                          message: 'What is your avoiding colors?'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),
            isLoading
                ? CircularProgressIndicator()
                : Wrap(
                    spacing: 20.w,
                    runSpacing: 20.h,
                    children: colors.map((color) {
                      return _buildColorCircle(
                          Color(int.parse(color['hex'].substring(1, 7),
                                  radix: 16) +
                              0xFF000000),
                          color['name']);
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color, String colorName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (avoidedSelectedColors.contains(colorName)) {
            avoidedSelectedColors.remove(colorName);
          } else {
            avoidedSelectedColors.add(colorName);
          }
        });
      },
      child: ColorCircle(
        color: color,
        isSelected: avoidedSelectedColors.contains(colorName),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
