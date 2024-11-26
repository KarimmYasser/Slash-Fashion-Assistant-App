import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/create_avatar/get_preferences.dart';
import 'package:fashion_assistant/tap_map.dart';
import 'package:fashion_assistant/utils/device/device_utility.dart';
import 'package:fashion_assistant/widgets/create_avatar/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class MaleOrFemale extends StatefulWidget {
  const MaleOrFemale({super.key});

  @override
  State<MaleOrFemale> createState() => _MaleOrFemaleState();
}

class _MaleOrFemaleState extends State<MaleOrFemale> {
  bool selectedMale = false, selectedFemale = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.backgroundColor,
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Are You",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                      selectedMale = true;
                      selectedFemale = false;
                    });
                  },
                  child: AvatarCard(
                    title: 'Male',
                    selected: selectedMale,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Or",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                      selectedMale = false;
                      selectedFemale = true;
                    });
                  },
                  child: AvatarCard(
                      title: 'Female',
                      isMalel: false,
                      selected: selectedFemale),
                ),
              ],
            )),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 80.w),
        child: Container(
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: OurColors.primaryColor,
          ),
          child: IconButton(
              onPressed: () => Get.offAll(() => GetPreferences()),
              icon: Text(
                'Next',
                style: TextStyle(color: OurColors.white, fontSize: 20.sp),
              )),
        ),
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
