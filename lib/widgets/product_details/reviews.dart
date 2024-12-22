import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/review.dart';
import 'package:fashion_assistant/screens/reviews_screen.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/widgets/product_details/five_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({super.key, required this.rate, required this.reviews});
  final double rate;
  final List<Map<String, dynamic>> reviews;

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

    return Container(
      width: double.infinity,
      color: OurColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.h, left: 16.w),
            child: Text(
              'Product Rating & Reviews',
              style: TextStyle(
                fontSize: Sizes.fontSizeLg,
                color: OurColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StarsSection(
            stars: rate,
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
            child: Column(
              children: [
                RatingsCardsList(
                  reviews: reviews,
                ),
                SizedBox(
                  height: 14.h,
                ),
                Reviews(
                  reviews: reviews,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StarsSection extends StatelessWidget {
  const StarsSection(
      {super.key,
      required this.stars,
      required this.fiveStarCount,
      required this.fourStarCount,
      required this.threeStarCount,
      required this.twoStarCount,
      required this.oneStarCount});
  final double stars;
  final int fiveStarCount;
  final int fourStarCount;
  final int threeStarCount;
  final int twoStarCount;
  final int oneStarCount;
  @override
  Widget build(BuildContext context) {
    int sum = fiveStarCount +
        fourStarCount +
        threeStarCount +
        twoStarCount +
        oneStarCount;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stars.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: Sizes.fontSizeLg * 1.5,
                  color: OurColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              FiveStarRating(filledStars: stars.toInt()),
              SizedBox(height: 4.h),
              Text(
                'Based on $sum reviews',
                style: TextStyle(
                  fontSize: Sizes.fontSizeSm,
                  color: OurColors.darkGrey,
                ),
              ),
            ],
          ),
          RatingBreakdown(
            fiveStarCount: fiveStarCount,
            fourStarCount: fourStarCount,
            threeStarCount: threeStarCount,
            twoStarCount: twoStarCount,
            oneStarCount: oneStarCount,
          ),
        ],
      ),
    );
  }
}

class RatingBreakdown extends StatelessWidget {
  const RatingBreakdown(
      {super.key,
      required this.fiveStarCount,
      required this.fourStarCount,
      required this.threeStarCount,
      required this.twoStarCount,
      required this.oneStarCount});
  final int fiveStarCount;
  final int fourStarCount;
  final int threeStarCount;
  final int twoStarCount;
  final int oneStarCount;
  @override
  Widget build(BuildContext context) {
    int sum = fiveStarCount +
        fourStarCount +
        threeStarCount +
        twoStarCount +
        oneStarCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar(
            stars: 5,
            percentage: (fiveStarCount / sum * 100).toInt(),
            color: Colors.green),
        RatingBar(
            stars: 4,
            percentage: (fourStarCount / sum * 100).toInt(),
            color: Colors.greenAccent),
        RatingBar(
            stars: 3,
            percentage: (threeStarCount / sum * 100).toInt(),
            color: OurColors.starColor),
        RatingBar(
            stars: 2,
            percentage: (twoStarCount / sum * 100).toInt(),
            color: Colors.orange),
        RatingBar(
            stars: 1,
            percentage: (oneStarCount / sum * 100).toInt(),
            color: Colors.red),
      ],
    );
  }
}

class RatingBar extends StatelessWidget {
  final int stars;
  final int percentage;
  final Color color;

  const RatingBar({
    super.key,
    required this.stars,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$stars', style: TextStyle(fontSize: Sizes.fontSizeSm)),
        SizedBox(width: 4.w),
        Icon(Iconsax.star1, size: 16.sp, color: color),
        SizedBox(width: 8.w),
        // Constrain the width of the SizedBox widget
        SizedBox(
          width: 100.w, // Define a fixed width or use a percentage-based width
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: LinearProgressIndicator(
              value: percentage / 100,
              color: color,
              backgroundColor: OurColors.grey,
              minHeight: 6.h,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Text('$percentage%', style: TextStyle(fontSize: Sizes.fontSizeSm)),
      ],
    );
  }
}

class RatingsCardsList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  RatingsCardsList({super.key, required this.reviews});

  Map<String, dynamic> getAverageRatings() {
    double qualitySum = 0;
    double valueForMoneySum = 0;
    double shippingSum = 0;
    double recommendationSum = 0;

    for (var review in reviews) {
      qualitySum += review['quality_rate'];
      valueForMoneySum += review['valueForMoney_rate'];
      shippingSum += review['shipping_rate'];
      recommendationSum += review['rating'];
    }

    int reviewCount = reviews.length;

    return {
      'Quality': qualitySum / reviewCount,
      'Value for Money': valueForMoneySum / reviewCount,
      'Shipping': shippingSum / reviewCount,
      'Recommendation': recommendationSum / reviewCount,
    };
  }

  @override
  Widget build(BuildContext context) {
    final list = getAverageRatings();
    final keys = list.keys.toList(); // Extract keys from the map

    return SizedBox(
      height: 40.h, // Constrain the height of the ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: keys.length, // Use the number of keys as the item count
        itemBuilder: (context, index) {
          final key = keys[index]; // Get the key for this index
          final value = list[key]; // Get the associated value

          return GestureDetector(
            onTap: () {
              // Add your onTap logic here if needed
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Container(
                height: 30.h, // Define consistent height
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: OurColors.containerBackgroundColor,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        key, // Display the category name (key)
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        ' ' +
                            value.toStringAsFixed(
                                1), // Display the rating (value)
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: OurColors.textColor,
                        ),
                      ),
                      Icon(
                        Iconsax.star1,
                        color: OurColors.starColor,
                        size: 16.sp,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({super.key, required this.reviews});
  final List<Map<String, dynamic>> reviews;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: TextStyle(
            fontSize: Sizes.fontSizeLg,
            color: OurColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.h, // Add spacing below the title
        ),
        // Fixed height for horizontal ListView
        SizedBox(
            height: 300.h, // Provide a fixed height for the horizontal ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Enables horizontal scrolling
              itemCount: reviews.length <= 5
                  ? reviews.length
                  : 5, // Number of review cards + 1 for the icon button
              itemBuilder: (context, index) {
                if (index == 4) {
                  // Adjust index to 4 as itemCount is 5
                  return SizedBox(
                    width: 100.w, // Adjust as needed
                    child: IconButton(
                      onPressed: () {
                        // Add your navigation logic here to navigate to the reviews page
                      },
                      icon: Icon(
                        Iconsax.arrow_circle_right4,
                        color: OurColors.secondaryTextColor, // Optional color
                        size: 50.sp, // Adjust size as needed
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                        right: 16.0), // Add spacing between cards
                    child: ReviewCard(
                      isExpanded: false,
                      review: Review.fromJson(reviews[index]),
                      reviews: reviews, // Pass the review object
                    ),
                  );
                }
              },
            )),
      ],
    );
  }
}

class ReviewCard extends StatefulWidget {
  const ReviewCard(
      {super.key,
      required this.isExpanded,
      required this.review,
      required this.reviews});
  final bool isExpanded;
  final Review review;
  final List<Map<String, dynamic>> reviews;
  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool isHelpfulClicked = false;
  int likesCount = 0;

  @override
  void initState() {
    super.initState();
    isHelpfulClicked = widget.review.liked;
    likesCount = widget.review.likes;
  }

  void _toggleHelpfulCount() async {
    final reviewId = widget.review.id;
    final url = 'api/review/like';

    final response = await HttpHelper.post(
      url,
      {
        'reviewId': reviewId,
      },
    );

    setState(() {
      if (isHelpfulClicked) {
        if (likesCount > 0) {
          likesCount -= 1;
        }
      } else {
        if (likesCount < widget.review.likes + 1) {
          likesCount += 1;
        }
      }
      isHelpfulClicked = !isHelpfulClicked;
    });
  }

  void _navigateToReviewsPage() {
    // Navigate to the reviews page (replace with your navigation logic)
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ReviewsScreen(
                reviews: widget.reviews,
                productId: widget.review.productId,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToReviewsPage,
      child: Container(
        constraints: BoxConstraints(maxWidth: 300), // Ensure max width only
        child: Card(
          color: OurColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.review.firstname} ${widget.review.lastname}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      widget.review.createdAt.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                FiveStarRating(filledStars: widget.review.rating.toInt()),
                SizedBox(height: 8),
                if (widget.review.image != '')
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.review.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(height: 8),
                Text(
                  widget.review.comment,
                  style: TextStyle(fontSize: 14),
                  maxLines: widget.isExpanded ? null : 2, // Dynamically adjust
                  overflow: widget.isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: _toggleHelpfulCount,
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(Iconsax.lamp_on4,
                          color: isHelpfulClicked
                              ? Colors.green
                              : OurColors.darkGrey,
                          size: 16),
                      SizedBox(width: 4),
                      Text(
                        "Helpful ($likesCount)",
                        style: TextStyle(
                          color: isHelpfulClicked
                              ? Colors.green
                              : OurColors.darkGrey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
