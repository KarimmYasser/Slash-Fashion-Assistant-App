import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateQuestions extends StatelessWidget {
  final Function(int, int) onRatingUpdate;

  const RateQuestions({super.key, required this.onRatingUpdate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('How satisfied are you with the product overall?',
              style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 10.h),
          StarRating(questionIndex: 0, onRatingUpdate: onRatingUpdate),
          SizedBox(height: 10.h),
          Text('How would you rate the product quality?',
              style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 10.h),
          StarRating(questionIndex: 1, onRatingUpdate: onRatingUpdate),
          SizedBox(height: 10.h),
          Text('Was the price fair for what you got?',
              style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 10.h),
          StarRating(questionIndex: 2, onRatingUpdate: onRatingUpdate),
          SizedBox(height: 10.h),
          Text('How fast was it the product delivered?',
              style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 10.h),
          StarRating(questionIndex: 3, onRatingUpdate: onRatingUpdate),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

class StarRating extends StatefulWidget {
  final int questionIndex;
  final Function(int, int) onRatingUpdate;

  const StarRating({
    super.key,
    required this.questionIndex,
    required this.onRatingUpdate,
  });

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _selectedStar = 0;

  void _onStarTap(int index) {
    setState(() {
      _selectedStar = index;
    });
    widget.onRatingUpdate(widget.questionIndex, index);
  }

  String filledStarAsset = 'assets/icons/star.png';
  String unfilledStarAsset = 'assets/icons/borderstar.png';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Image.asset(
            scale: 1,
            index < _selectedStar ? filledStarAsset : unfilledStarAsset,
            fit: BoxFit.contain, // Ensure the image scales properly
          ),
          onPressed: () => _onStarTap(index + 1),
        );
      }),
    );
  }
}
