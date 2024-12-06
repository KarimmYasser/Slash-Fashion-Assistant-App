import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/home_page/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class AddCartAppBar extends StatelessWidget {
  const AddCartAppBar({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: OurColors.backgroundColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: const Color.fromARGB(255, 242, 242, 245)),
                  child: IconButton(
                    icon: Icon(Iconsax.share, color: OurColors.primaryColor),
                    onPressed: () {
                      // Handle favorite action
                    },
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: const Color.fromARGB(255, 242, 242, 245)),
                  child: IconButton(
                    icon: FavoriteButton(productId: productId),
                    onPressed: () {
                      // Handle favorite action
                    },
                  ),
                ),
              ],
            ),
            // Add to Cart button
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OurColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 0),
                  ),
                  onPressed: () {
                    // Handle add to cart action
                  },
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
