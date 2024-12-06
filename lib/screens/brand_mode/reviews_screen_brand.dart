import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/product_details/reviews.dart';
import 'package:flutter/material.dart';
import 'package:fashion_assistant/screens/add_review_screen.dart'; // Import the AddReviewScreen
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsScreenBrand extends StatelessWidget {
  const ReviewsScreenBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.secondaryBackgroundColor,
      appBar: AppBar(
        title: Text('Product ratings and reviews'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StarsSection(stars: 4.5),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 18.h, left: 16.w),
              child: RatingsCardsList(),
            ),
            Text('6 Reviews',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
                  child: ReviewCard(
                    isExpanded: true,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
