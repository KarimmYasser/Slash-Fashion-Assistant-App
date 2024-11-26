import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorsList extends StatefulWidget {
  const ColorsList({super.key, required this.colorsList});
  final List<Map<String, String>> colorsList;

  @override
  _ColorsListState createState() => _ColorsListState();
}

class _ColorsListState extends State<ColorsList> {
  int selectedIndex = 0; // Default to the first color

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'Colors:',
            style: TextStyle(
                color: OurColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: Sizes.fontSizeLg),
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 80.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.colorsList.length,
            itemBuilder: (context, index) {
              bool isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index; // Update selected index
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    height: 70.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: OurColors.iconPrimary.withOpacity(0.2),
                      border: isSelected
                          ? Border.all(
                              color: Colors.blue,
                              width: 2.0) // Blue border for selected color
                          : Border.all(color: Colors.transparent),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.r),
                        child: Image.network(
                          widget.colorsList[index]['image']!,
                          width: 55.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
