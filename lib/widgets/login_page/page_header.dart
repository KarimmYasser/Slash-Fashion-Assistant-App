import '../../constants.dart';
import 'package:flutter/material.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          'assets/logo/logo_black.png',
          height: Sizes.logoheight,
        ),
        Text('Welcome Back!',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: Sizes.sm),
        Text(
          'Discover Your Unique Style.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
