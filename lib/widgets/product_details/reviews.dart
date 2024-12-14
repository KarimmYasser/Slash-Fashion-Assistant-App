import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/add_review_screen.dart';
import 'package:fashion_assistant/screens/reviews_screen.dart';
import 'package:fashion_assistant/screens/show_list_screen.dart';
import 'package:fashion_assistant/widgets/product_details/five_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({super.key, required this.rate});
  final double rate;
  @override
  Widget build(BuildContext context) {
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
          StarsSection(stars: rate),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(top: 18.h, left: 16.w),
            child: Column(
              children: [
                RatingsCardsList(),
                SizedBox(
                  height: 14.h,
                ),
                Reviews()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StarsSection extends StatelessWidget {
  const StarsSection({super.key, required this.stars});
  final double stars;

  @override
  Widget build(BuildContext context) {
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
                'Based on 1.2k reviews',
                style: TextStyle(
                  fontSize: Sizes.fontSizeSm,
                  color: OurColors.darkGrey,
                ),
              ),
            ],
          ),
          const RatingBreakdown(),
        ],
      ),
    );
  }
}

class RatingBreakdown extends StatelessWidget {
  const RatingBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        RatingBar(stars: 5, percentage: 78, color: Colors.green),
        RatingBar(stars: 4, percentage: 8, color: Colors.greenAccent),
        RatingBar(stars: 3, percentage: 2, color: OurColors.starColor),
        RatingBar(stars: 2, percentage: 1, color: Colors.orange),
        RatingBar(stars: 1, percentage: 1, color: Colors.red),
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
  RatingsCardsList({super.key});

  final Map<String, dynamic> list = {
    'Quality': 4.5,
    'Value for Money': 4,
    'Shipping': 3.8,
    'Recommendation': 3.8,
  };

  @override
  Widget build(BuildContext context) {
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
                        ' ' + value.toString(), // Display the rating (value)
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
  const Reviews({super.key});

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
              itemCount: 5, // Number of review cards + 1 for the icon button
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
  const ReviewCard({super.key, required this.isExpanded});
  final bool isExpanded;
  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  int helpfulCount = 2;
  bool isHelpfulClicked = false;

  void _toggleHelpfulCount() {
    setState(() {
      if (isHelpfulClicked) {
        helpfulCount -= 1;
      } else {
        helpfulCount += 1;
      }
      isHelpfulClicked = !isHelpfulClicked;
    });
  }

  void _navigateToReviewsPage() {
    // Navigate to the reviews page (replace with your navigation logic)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewsScreen()),
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
                      "Toqa Samir",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "20/08/2024",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                FiveStarRating(filledStars: 5),
                SizedBox(height: 8),
                Text(
                  "Great quality",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Absolutely love this scarf, the colors are beyond amazing and the material as well. "
                  "The colors are vibrant, and it feels so soft on the skin. It's exactly what I was looking for.",
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
                          color: OurColors.darkGrey, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "Helpful ($helpfulCount)",
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
