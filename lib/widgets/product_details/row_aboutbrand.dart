import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowAboutbrand extends StatelessWidget {
  const RowAboutbrand({
    super.key,
    required this.icon,
    required this.text,
    this.row = false,
    this.perc = 0,
  });

  final IconData icon;
  final String text;
  final bool row;
  final double perc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          icon,
          color: OurColors.primaryColor,
          size: 24.sp,
        ),
        SizedBox(
          width: 6.w,
        ),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text and row to the left
          children: [
            Text(
              text,
              style: TextStyle(
                color: OurColors.textColor,
                fontSize: 12.sp,
              ),
            ),
            if (row)
              SizedBox(
                width: 150.w, // Set a fixed width for the progress bar
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(50.0), // Rounded corners
                        child: LinearProgressIndicator(
                          value: perc, // Progress value between 0.0 and 1.0
                          color: Colors.green,
                          backgroundColor: OurColors.grey,
                          minHeight: 10.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10, // Space between progress bar and percentage
                    ),
                    Text(
                      '${(perc * 100).toStringAsFixed(0)}%', // Format percentage value
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        )
      ],
    );
  }
}
