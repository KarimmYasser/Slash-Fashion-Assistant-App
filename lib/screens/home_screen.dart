import 'package:fashion_assistant/widgets/custom_button.dart';
import 'package:fashion_assistant/widgets/custom_navbar.dart';
import 'package:fashion_assistant/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ProductCard(
      brandShowcase: 'brandShowcase',
      description: 'description',
      height: 300.h,
      width: 300.w,
    ));
  }
}
