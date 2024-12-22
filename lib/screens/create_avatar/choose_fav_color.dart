import 'dart:convert';

import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/create_avatar/color_circle.dart';
import 'package:fashion_assistant/widgets/create_avatar/question_pubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class ChooseFavColor extends StatefulWidget {
  const ChooseFavColor({super.key, required this.onSelection});
  final void Function() onSelection;
  @override
  State<ChooseFavColor> createState() => _ChooseFavColorState();
}

class _ChooseFavColorState extends State<ChooseFavColor>
    with AutomaticKeepAliveClientMixin {
  Map<String, dynamic> getMap() {
    if (isMale)
      return avatarsMap['male']!;
    else
      return avatarsMap['female']!;
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
                        message: 'What is your favorite color in clothes?'),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 0;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 0;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xff65C9FF),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 1;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 1;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xff5099E4),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 2;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 2;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xffFFFFB1),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 3;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 3;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xffA7FFC4),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 4;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 4;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xff929598),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 5;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 5;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 6;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 6;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xff27557C),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 7;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 7;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xffE6E6E6),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 8;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 8;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xff3D4E5C),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 10;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 10;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xffFFDEB5),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 11;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 11;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xffFFAFB9),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 12;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 12;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xffFF488E),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 13;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 13;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: Color(0xffFF5C5C),
                ),
              ),
              SizedBox(
                width: 40.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isMale) {
                      avatarsMap['male']!['clotheColor'] = 14;
                    } else {
                      avatarsMap['female']!['clotheColor'] = 14;
                    }
                  });
                  widget.onSelection();
                },
                child: ColorCircle(
                  color: const Color.fromARGB(255, 252, 251, 251),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
