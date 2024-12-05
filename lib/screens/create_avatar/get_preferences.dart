import 'dart:convert';
import 'dart:io';

import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/create_avatar/avoiding_colors.dart';
import 'package:fashion_assistant/screens/create_avatar/choose_body_color.dart';
import 'package:fashion_assistant/screens/create_avatar/choose_facial_hair.dart';
import 'package:fashion_assistant/screens/create_avatar/choose_facialhair_color.dart';
import 'package:fashion_assistant/screens/create_avatar/choose_fav_color.dart';
import 'package:fashion_assistant/screens/create_avatar/choose_favorite_colors.dart';
import 'package:fashion_assistant/screens/create_avatar/choose_hair_color.dart';
import 'package:fashion_assistant/screens/create_avatar/choose_haircut.dart';
import 'package:fashion_assistant/screens/create_avatar/choose_shirts_style.dart';
import 'package:fashion_assistant/screens/create_avatar/male_or_female.dart';
import 'package:fashion_assistant/screens/create_avatar/photos_selection_page.dart';
import 'package:fashion_assistant/screens/total_screen.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

List<Map<String, dynamic>> selectedProducts = [];
List<String> selectedColors = [];
List<String> avoidedSelectedColors = [];

class GetPreferences extends StatefulWidget {
  const GetPreferences({super.key});

  @override
  State<GetPreferences> createState() => _GetPreferencesState();
}

class _GetPreferencesState extends State<GetPreferences> {
  int _activeScreen = 0;
  final PageController _pageController = PageController(initialPage: 0);

  // Define the total number of screens here for easy management
  final int _totalScreens =
      isMale ? 9 : 7; // Adjust based on conditional screens
  void _showAvatarPopup(BuildContext context) async {
    String? avatarSvg;
    Map<String, dynamic> avatarData = {};

    try {
      debugPrint("isMale: $isMale");
      String avatarJson =
          json.encode(isMale ? avatarsMap['male'] : avatarsMap['female']);
      debugPrint("Avatar JSON: $avatarJson");

      avatarSvg =
          await FluttermojiFunctions().decodeFluttermojifromString(avatarJson);

      // Parse the avatar JSON into a Map
      avatarData = json.decode(avatarJson) as Map<String, dynamic>;
      debugPrint("Parsed avatar data: $avatarData");
    } catch (e) {
      debugPrint("Error loading avatar SVG: $e");
    }

    if (avatarSvg == null) {
      debugPrint("Avatar SVG is null, cannot display avatar.");
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: OurColors.secondaryBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            height: 350.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Avatar",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: OurColors.textColor,
                  ),
                ),
                SizedBox(height: 20.h),

                // Display the user's avatar SVG
                if (avatarSvg != null)
                  SvgPicture.string(
                    avatarSvg,
                    width: 150.w,
                    height: 150.h,
                    placeholderBuilder: (BuildContext context) =>
                        const CircularProgressIndicator(),
                  )
                else
                  const Text("Error loading avatar"),

                SizedBox(height: 20.h),

                // Row with "Edit" and "Okay" buttons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Edit Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          _pageController.jumpToPage(
                              0); // Go back to the first screen for editing
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: OurColors.containerBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: OurColors.primaryColor,
                          ),
                        ),
                      ),

                      // Okay Button
                      ElevatedButton(
                        onPressed: () async {
                          // Close the dialog
                          _sendColorsToBackend();
                          saveSelectedProducts('generalProduct');
                          try {
                            final response = await HttpHelper.post(
                              'api/user/avatar',
                              avatarData,
                            );

                            if (response['message'] ==
                                'Avatar saved successfully') {
                              debugPrint('Avatar data sent successfully');
                            } else {
                              throw Exception(
                                  'Unexpected response: ${response.toString()}');
                            }
                          } catch (error) {
                            debugPrint('Error sending avatar data: $error');
                          }

                          Get.offAll(() => TotalScreens());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: OurColors.containerBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          "Okay",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: OurColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _sendColorsToBackend() async {
    final url = 'color_perefrereneces';
    final body = {
      'avoidedColors': avoidedSelectedColors,
      'selectedColors': selectedColors,
    };

    try {
      final response = await HttpHelper.post(url, body);

      if (response['statusCode'] == 200) {
        debugPrint('Colors sent successfully');
      } else {
        debugPrint('Failed to send colors: ${response['meassage']}');
      }
    } catch (e) {
      debugPrint('Error sending colors: $e');
    }
  }

  Future<void> saveSelectedProducts(String generalProduct) async {
    try {
      final List<String> selectedIds =
          selectedProducts.map((product) => product['id'] as String).toList();
      print('Selected IDs: $selectedIds');

      final payload = {
        'products': selectedIds,
      };

      // Use the existing `post` function
      final response =
          await HttpHelper.post('api/user/style-preferences', payload);

      // Check the response content instead of relying on `statusCode`
      if (response['message'] == 'Style preferences set successfully') {
        print(
            '=================================================================');
        print(selectedIds);
        print('Sent successfully');
        print(
            '=================================================================');
      } else {
        throw Exception('Unexpected response: ${response.toString()}');
      }
    } catch (error) {
      print('Error saving selected products: $error');
    }
  }

  void _nextPage() {
    if (_activeScreen < _totalScreens - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }
  }

  void _previousPage() {
    if (_activeScreen > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.backgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _activeScreen = index;
          });
        },
        children: [
          ChooseBodyColor(
            onSelection: _nextPage,
          ),
          ChooseHaircut(
            onSelection: _nextPage,
          ),
          ChooseHairColor(
            onSelection: _nextPage,
          ),
          if (isMale)
            ChooseFacialHair(
              onSelection: _nextPage,
            ),
          if (isMale)
            ChooseFacialhairColor(
              onSelection: _nextPage,
            ),
          ChooseFavColor(
            onSelection: _nextPage,
          ),
          ChooseFavColors(),
          AvoidingColors(),
          ChooseStyle(),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: OurColors.softGrey,
              ),
              child: IconButton(
                onPressed: _activeScreen > 0
                    ? _previousPage
                    : () => Get.offAll(() => MaleOrFemale()),
                icon: Icon(
                  Iconsax.arrow_left,
                  color: OurColors.primaryColor,
                ),
              ),
            ),
            // Next button
            // Next button
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: OurColors.softGrey,
              ),
              child: IconButton(
                onPressed: () {
                  debugPrint(
                      "Next button pressed, _activeScreen: $_activeScreen, _totalScreens: $_totalScreens");
                  if (_activeScreen < _totalScreens - 1) {
                    _nextPage();
                  } else if (_activeScreen == _totalScreens - 1) {
                    debugPrint(
                        "Triggering avatar popup from the button..."); // This should appear if logic is correct
                    _showAvatarPopup(context);
                  }
                },
                icon: Icon(
                  Iconsax.arrow_right_1,
                  color: OurColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
