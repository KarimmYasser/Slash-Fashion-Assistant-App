import 'dart:convert';

import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/create_avatar/choose_card.dart';
import 'package:fashion_assistant/widgets/create_avatar/question_pubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class ChooseFacialHair extends StatefulWidget {
  const ChooseFacialHair({super.key, required this.onSelection});
  final void Function() onSelection;
  @override
  State<ChooseFacialHair> createState() => _ChooseFacialHairState();
}

class _ChooseFacialHairState extends State<ChooseFacialHair>
    with AutomaticKeepAliveClientMixin {
  bool selected1 = false, selected2 = false, seleceted4 = false;
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
                    width: 200.w,
                    child: QuestionPubble(
                        message: 'what type of facial hair do you have?'),
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

                if (isMale) {
                  avatarsMap['male']!['facialHairType'] = 4;
                } else {
                  avatarsMap['female']!['facialHairType'] = 4;
                }
              });
              widget.onSelection();
            },
            child: ChooseCard(
              data: 'mustache',
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

                if (isMale) {
                  avatarsMap['male']!['facialHairType'] = 2;
                } else {
                  avatarsMap['female']!['facialHairType'] = 2;
                }
              });
              widget.onSelection();
            },
            child: ChooseCard(
              data: 'Chin hair',
              selected: selected2,
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

                if (isMale) {
                  avatarsMap['male']!['facialHairType'] = 0;
                } else {
                  avatarsMap['female']!['facialHairType'] = 0;
                }
              });
              widget.onSelection();
            },
            child: ChooseCard(
              data: 'Without',
              selected: seleceted4,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
