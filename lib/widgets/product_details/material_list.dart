import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaterialList extends StatelessWidget {
  const MaterialList({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: const Text(
            'Material:',
            style: TextStyle(
                color: OurColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: Sizes.fontSizeLg),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      height: 25.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: const Color.fromARGB(255, 228, 223, 223),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                            name,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
      ],
    );
  }
}
