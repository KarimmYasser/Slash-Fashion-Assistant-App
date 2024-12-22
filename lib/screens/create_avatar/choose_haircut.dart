import 'dart:convert';

import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/widgets/create_avatar/choose_card.dart';

import 'package:fashion_assistant/widgets/create_avatar/question_pubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class ChooseHaircut extends StatefulWidget {
  const ChooseHaircut({super.key, required this.onSelection});
  final void Function() onSelection;
  @override
  State<ChooseHaircut> createState() => _ChooseHaircutState();
}

class _ChooseHaircutState extends State<ChooseHaircut>
    with AutomaticKeepAliveClientMixin {
  bool selected1 = false,
      selected2 = false,
      seleceted3 = false,
      seleceted4 = false,
      seleceted5 = false;

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
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 150.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
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
                          message: 'What is your hair type?'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            isMale
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        seleceted4 = false;
                        selected1 = true;
                        selected2 = false;
                        seleceted3 = false;
                        seleceted5 = false;
                        if (isMale) {
                          avatarsMap['male']!['topType'] = 6;
                        } else {
                          avatarsMap['female']!['topType'] = 6;
                        }
                      });
                      widget.onSelection();
                    },
                    child: ChooseCard(
                      data: 'short',
                      selected: selected1,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        seleceted4 = false;
                        selected1 = true;
                        selected2 = false;
                        seleceted3 = false;
                        seleceted5 = false;
                        if (isMale) {
                          avatarsMap['male']!['topType'] = 22;
                        } else {
                          avatarsMap['female']!['topType'] = 22;
                        }
                      });
                      widget.onSelection();
                    },
                    child: ChooseCard(
                      data: 'Straight and tall',
                      selected: selected1,
                    ),
                  ),
            SizedBox(
              height: 20.h,
            ),
            isMale
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        seleceted4 = false;
                        selected1 = false;
                        selected2 = true;
                        seleceted3 = false;
                        seleceted5 = false;
                        if (isMale) {
                          avatarsMap['male']!['topType'] = 20;
                        } else {
                          avatarsMap['female']!['topType'] = 20;
                        }
                      });
                      widget.onSelection();
                    },
                    child: ChooseCard(
                      data: 'tall',
                      selected: selected2,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        seleceted4 = false;
                        selected1 = false;
                        selected2 = true;
                        seleceted3 = false;
                        seleceted5 = false;
                        if (isMale) {
                          avatarsMap['male']!['topType'] = 17;
                        } else {
                          avatarsMap['female']!['topType'] = 17;
                        }
                      });
                      widget.onSelection();
                    },
                    child: ChooseCard(
                      data: 'Straight and short',
                      selected: selected2,
                    ),
                  ),
            SizedBox(
              height: 20.h,
            ),
            isMale
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        seleceted4 = false;
                        selected1 = false;
                        selected2 = false;
                        seleceted3 = true;
                        seleceted5 = false;
                        if (isMale) {
                          avatarsMap['male']!['topType'] = 16;
                        } else {
                          avatarsMap['female']!['topType'] = 16;
                        }
                      });
                      widget.onSelection();
                    },
                    child: ChooseCard(
                      data: 'Curly',
                      selected: seleceted3,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        seleceted4 = false;
                        selected1 = false;
                        selected2 = false;
                        seleceted3 = true;
                        seleceted5 = false;
                        if (isMale) {
                          avatarsMap['male']!['topType'] = 18;
                        } else {
                          avatarsMap['female']!['topType'] = 18;
                        }
                      });
                      widget.onSelection();
                    },
                    child: ChooseCard(
                      data: 'Curly and tall',
                      selected: seleceted3,
                    ),
                  ),
            SizedBox(
              height: 20.h,
            ),
            isMale
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        seleceted4 = true;
                        selected1 = false;
                        selected2 = false;
                        seleceted3 = false;
                        seleceted5 = false;
                        if (isMale) {
                          avatarsMap['male']!['topType'] = 0;
                        } else {
                          avatarsMap['female']!['topType'] = 0;
                        }
                      });
                      widget.onSelection();
                    },
                    child: ChooseCard(
                      data: 'Without',
                      selected: seleceted4,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        seleceted4 = true;
                        selected1 = false;
                        selected2 = false;
                        seleceted3 = false;
                        seleceted5 = false;
                        if (isMale) {
                          avatarsMap['male']!['topType'] = 25;
                        } else {
                          avatarsMap['female']!['topType'] = 25;
                        }
                      });
                      widget.onSelection();
                    },
                    child: ChooseCard(
                      data: 'Curly and short',
                      selected: seleceted4,
                    ),
                  ),
            SizedBox(
              height: 20.h,
            ),
            if (!isMale)
              GestureDetector(
                onTap: () {
                  setState(() {
                    seleceted4 = false;
                    selected1 = false;
                    selected2 = false;
                    seleceted3 = false;
                    seleceted5 = true;
                    if (isMale) {
                      avatarsMap['male']!['topType'] = 2;
                    } else {
                      avatarsMap['female']!['topType'] = 2;
                    }
                  });
                  widget.onSelection();
                },
                child: ChooseCard(
                  data: 'Hejab',
                  selected: seleceted5,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
