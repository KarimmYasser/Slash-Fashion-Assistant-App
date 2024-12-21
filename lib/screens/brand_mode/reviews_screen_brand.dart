import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/review.dart';
import 'package:fashion_assistant/widgets/product_details/reviews.dart';
import 'package:flutter/material.dart';
import 'package:fashion_assistant/screens/add_review_screen.dart'; // Import the AddReviewScreen
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsScreenBrand extends StatelessWidget {
  const ReviewsScreenBrand(
      {super.key, required this.reviews, required this.productId});
  final List<Map<String, dynamic>> reviews;
  final String productId;
  @override
  Widget build(BuildContext context) {
    int fiveStarCount =
        reviews.where((review) => review['rating'].toInt() == 5).length;
    int fourStarCount =
        reviews.where((review) => review['rating'].toInt() == 4).length;
    int threeStarCount =
        reviews.where((review) => review['rating'].toInt() == 3).length;
    int twoStarCount =
        reviews.where((review) => review['rating'].toInt() == 2).length;
    int oneStarCount =
        reviews.where((review) => review['rating'].toInt() == 1).length;

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
            StarsSection(
              stars: 4.5,
              fiveStarCount: fiveStarCount,
              fourStarCount: fourStarCount,
              threeStarCount: threeStarCount,
              twoStarCount: twoStarCount,
              oneStarCount: oneStarCount,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 18.h, left: 16.w),
              child: RatingsCardsList(
                reviews: reviews,
              ),
            ),
            Text('Reviews',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
                  child: ReviewCard(
                    isExpanded: true,
                    review: Review.fromJson(reviews[index]),
                    reviews: reviews,
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
