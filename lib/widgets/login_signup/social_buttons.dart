import '../../constants.dart';
import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const SizedBox(width: Sizes.iconMd),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/logo/gmail.png',
            height: Sizes.iconLg,
            fit: BoxFit.fitHeight,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/logo/facebook.png',
            height: Sizes.iconLg,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/logo/instagram.png',
            height: Sizes.iconLg,
          ),
        ),
        const SizedBox(width: Sizes.iconMd),
      ],
    );
  }
}
