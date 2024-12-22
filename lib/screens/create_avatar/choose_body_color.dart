import 'dart:convert';

import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/create_avatar/choose_color_card.dart';
import 'package:fashion_assistant/widgets/create_avatar/question_pubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class ChooseBodyColor extends StatefulWidget {
  const ChooseBodyColor({super.key, required this.onSelection});
  final void Function() onSelection;
  @override
  State<ChooseBodyColor> createState() => _ChooseBodyColorState();
}

class _ChooseBodyColorState extends State<ChooseBodyColor>
    with AutomaticKeepAliveClientMixin {
  bool selected1 = false,
      selected2 = false,
      seleceted3 = false,
      seleceted4 = false;
  Map<String, dynamic> getMap() {
    if (isMale) {
      return avatarsMap['male']!;
    } else {
      return avatarsMap['female']!;
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

  Future<String> loadAvatar() async {
    try {
      // Convert the avatar map to JSON, then decode it to SVG string
      String avatarJson = json.encode(avatarMap);
      return FluttermojiFunctions().decodeFluttermojifromString(avatarJson);
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
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text("Error loading avatar");
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return SvgPicture.string(
                        snapshot.data!,
                        width: 80,
                        height: 80,
                        placeholderBuilder: (BuildContext context) =>
                            const CircularProgressIndicator(),
                      );
                    } else {
                      return const Text("Error loading avatar");
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 60.h),
                  child: SizedBox(
                    width: 200.w,
                    child: const QuestionPubble(
                        message: 'What is the closest color to your skin?'),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                seleceted4 = false;
                selected1 = true;
                selected2 = false;
                seleceted3 = false;
                if (isMale) {
                  avatarsMap['male']!['skinColor'] = 0;
                } else {
                  avatarsMap['female']!['skinColor'] = 0;
                }
              });
              widget.onSelection();
            },
            child: ChooseColorCard(
              color: const Color(0xffFFDBB4),
              data: 'White',
              selected: selected1,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                seleceted4 = false;
                selected1 = false;
                selected2 = true;
                seleceted3 = false;
                if (isMale) {
                  avatarsMap['male']!['skinColor'] = 1;
                } else {
                  avatarsMap['female']!['skinColor'] = 1;
                }
              });
              widget.onSelection();
            },
            child: ChooseColorCard(
              color: const Color(0xffEDB98A),
              data: 'Wheaty',
              selected: selected2,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                seleceted4 = false;
                selected1 = false;
                selected2 = false;
                seleceted3 = true;
                if (isMale) {
                  avatarsMap['male']!['skinColor'] = 3;
                } else {
                  avatarsMap['female']!['skinColor'] = 3;
                }
              });
              widget.onSelection();
            },
            child: ChooseColorCard(
              color: const Color(0xffD08B5A),
              data: 'Brown',
              selected: seleceted3,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                seleceted4 = true;
                selected1 = false;
                selected2 = false;
                seleceted3 = false;
                if (isMale) {
                  avatarsMap['male']!['skinColor'] = 2;
                } else {
                  avatarsMap['female']!['skinColor'] = 2;
                }
              });
              widget.onSelection();
            },
            child: ChooseColorCard(
              color: const Color(0xff604235),
              data: 'Dark Brwon',
              selected: seleceted4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
