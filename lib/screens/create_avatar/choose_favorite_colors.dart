import 'dart:convert';

import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/create_avatar/choose_color_card.dart';
import 'package:fashion_assistant/widgets/create_avatar/color_circle.dart';
import 'package:fashion_assistant/widgets/create_avatar/question_pubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class ChooseFavColors extends StatefulWidget {
  const ChooseFavColors({super.key, required this.onSelection});
  final void Function() onSelection;

  @override
  State<ChooseFavColors> createState() => _ChooseFavColorsState();
}

class _ChooseFavColorsState extends State<ChooseFavColors>
    with AutomaticKeepAliveClientMixin {
  Map<String, dynamic> getMap() {
    return isMale ? avatarsMap['male']! : avatarsMap['female']!;
  }

  String? avatarSvg;
  bool isLoading = true;
  late Map<String, dynamic> avatarMap;

  // Store indices and names of selected colors
  List<int> selectedColorIndices = [];
  List<String> selectedColorNames = [];

  final Map<int, Color> colorOptions = {
    0: Color(0xff65C9FF),
    1: Color(0xffFFD700),
    2: Color(0xffFF4500),
    // Add more colors here
  };

  final Map<int, String> colorNames = {
    0: "Sky Blue",
    1: "Gold",
    2: "Orange",
    // Add corresponding color names
  };

  @override
  void initState() {
    super.initState();
    avatarMap = getMap();
    loadAvatar();
  }

  Future<String> loadAvatar() async {
    try {
      String avatarJson = json.encode(avatarMap);
      return await FluttermojiFunctions()
          .decodeFluttermojifromString(avatarJson);
    } catch (error) {
      throw Exception("Error loading avatar SVG");
    }
  }

  void toggleColorSelection(int colorIndex) {
    setState(() {
      if (selectedColorIndices.contains(colorIndex)) {
        selectedColorIndices.remove(colorIndex);
        selectedColorNames.remove(colorNames[colorIndex]);
      } else {
        selectedColorIndices.add(colorIndex);
        selectedColorNames.add(colorNames[colorIndex]!);
      }
    });
    widget.onSelection();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Avatar display section (as is)
          Row(
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
                      placeholderBuilder: (context) =>
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
                  child:
                      QuestionPubble(message: 'What are your favorite colors?'),
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),

          // Display selected colors in a row
          Wrap(
            spacing: 10,
            children: selectedColorIndices.map((index) {
              return ColorCircle(color: colorOptions[index]!);
            }).toList(),
          ),
          SizedBox(height: 20.h),

          // Row of color options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: colorOptions.entries.map((entry) {
              return GestureDetector(
                onTap: () => toggleColorSelection(entry.key),
                child: ColorCircle(color: entry.value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
