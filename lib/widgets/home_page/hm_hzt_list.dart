import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/show_list_screen.dart';
import 'package:fashion_assistant/widgets/home_page/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList(
      {super.key,
      required this.brandSHowcase,
      required this.description,
      required this.discount,
      required this.image,
      required this.price,
      required this.coin,
      required this.height,
      required this.width,
      required this.title});
  final String title, brandSHowcase, description, discount, image, price, coin;
  final double height, width;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: OurColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp)),
        SizedBox(
          height: 250.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 11,
            itemBuilder: (context, index) {
              return index == 10
                  ? SizedBox(
                      width: 100.w, // Adjust as needed
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowListScreen(title: title),
                            ),
                          );
                        },
                        icon: Icon(
                          Iconsax.arrow_circle_right4,
                          color: OurColors.secondaryTextColor, // Optional color
                          size: 50.sp, // Adjust size as needed
                        ),
                      ),
                    )
                  : ProductCard(
                      brandShowcase: brandSHowcase,
                      description: description,
                      height: height.h,
                      width: width.h,
                      discount: discount,
                      price: price,
                      coin: coin,
                      image: image,
                      small: true,
                    );
            },
          ),
        ),
      ],
    );
  }
}
