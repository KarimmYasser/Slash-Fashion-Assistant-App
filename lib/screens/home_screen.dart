import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/custom_button.dart';
import 'package:fashion_assistant/widgets/custom_navbar.dart';
import 'package:fashion_assistant/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 400.h,
          pinned: true,
          toolbarHeight: Sizes.appBarHeight,
          backgroundColor: OurColors.backgroundColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.searchengin,
                color: OurColors.iconPrimary,
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 16, bottom: 16),
            title: Text(
              'Slash Styliest',
              style: TextStyle(
                color: OurColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Image.network(
                    'https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 250.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ProductCard(
                          brandShowcase: 'brandShowcase',
                          description: 'description',
                          height: 250.h,
                          width: 200.w,
                          discount: '30',
                          price: '300',
                          coin: 'EGP',
                          image:
                              'https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=',
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 250.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ProductCard(
                          brandShowcase: 'Another Brand',
                          description: 'Another product description',
                          height: 250.h,
                          width: 200.w,
                          discount: '20',
                          price: '150',
                          coin: 'EGP',
                          image:
                              'https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
