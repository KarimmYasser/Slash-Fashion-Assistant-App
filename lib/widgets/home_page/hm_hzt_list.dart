import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/show_list_screen.dart';
import 'package:fashion_assistant/widgets/product/product_card.dart';

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
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(title,
              style: TextStyle(
                  color: OurColors.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.fontSizeLg)),
        ),
        SizedBox(
          height: 410.h,
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
                      brandImage:
                          'https://s3-alpha-sig.figma.com/img/709b/907e/4e3118132f60e1919c5891c6e22883fe?Expires=1731283200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qnF7TC5k8yOoJLEs4Ahuiip23Rr0BP3HMCK6U-fRo1nkRiQxaGks3iGPIXTKfduvmvGGcamJ9aKlccNZhnIEvvif2EFsIfgxAiW9kXLEFNyuKOuOoD9YwNRT91DbkkgNZuIZjsjdzhu1JS00bxn778jDGTBnJ3E50vnghuEW3xY1MWFb24-gy88W4ZePae22MM6CwltLndPFkdLziNow5F45jn4ObRhMifbTl5puhUBUDHaLb9xO8srJZS0vJxoOoNbiBz9YT9EK5IhLoFMqcJvd3si6-TVNcD-c75zQlCSuXURnGZ65dPBQVHRWtHSgCTebju1yvjiVaETxQPwtlw__',
                      brandName: 'Fashoni',
                      brandShowcase: '100% Natural Cotton Suit',
                      prevprice: '400',
                      price: '300',
                      discound: '20',
                      sold: '130',
                      numReviewers: '132',
                      starts: '5',
                      coin: 'EGP',
                    );
            },
          ),
        ),
      ],
    );
  }
}
