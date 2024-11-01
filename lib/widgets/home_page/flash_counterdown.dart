import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fashion_assistant/constants.dart';

class FlashSaleCountdown extends StatefulWidget {
  const FlashSaleCountdown({
    super.key,
    required this.days,
    required this.hours,
    required this.minutes,
  });

  final int days, hours, minutes;

  @override
  _FlashSaleCountdownState createState() => _FlashSaleCountdownState();
}

class _FlashSaleCountdownState extends State<FlashSaleCountdown> {
  late Duration remainingTime;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    remainingTime = Duration(
      days: widget.days,
      hours: widget.hours,
      minutes: widget.minutes,
    );
    timer = Timer.periodic(Duration(seconds: 1), (_) => _updateCountdown());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _updateCountdown() {
    setState(() {
      if (remainingTime > Duration(seconds: 1)) {
        remainingTime = remainingTime - Duration(seconds: 1);
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Flash Sale",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 50.w),
          Text(
            "Closing in:",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8.w),
          _buildTimeBox(_formatTime(remainingTime.inDays)), // Days
          _buildColon(),
          _buildTimeBox(_formatTime(remainingTime.inHours % 24)), // Hours
          _buildColon(),
          _buildTimeBox(_formatTime(remainingTime.inMinutes % 60)), // Minutes
        ],
      ),
    );
  }

  Widget _buildTimeBox(String value) {
    return Container(
      height: 30.h,
      width: 30.w,
      decoration: BoxDecoration(
        color: OurColors.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: OurColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildColon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ":",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: OurColors.primaryColor,
        ),
      ),
    );
  }
}
