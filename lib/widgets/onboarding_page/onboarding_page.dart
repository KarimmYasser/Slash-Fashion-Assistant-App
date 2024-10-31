import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.headlineText,
    required this.bodyText,
  });

  final String image;
  final String headlineText;
  final String bodyText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: HelperFunctions.screenWidth() * 0.8,
            height: HelperFunctions.screenHeight() * 0.6,
            image: AssetImage(image),
          ),
          Text(
            headlineText,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Sizes.spaceBtwItems),
          Text(
            bodyText,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}