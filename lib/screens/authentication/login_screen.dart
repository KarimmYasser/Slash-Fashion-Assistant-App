import '../../widgets/login_page/login_form.dart';
import '../../widgets/login_page/page_header.dart';
import '../../widgets/login_signup/form_divider.dart';

import '../../widgets/login_signup/social_buttons.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            Sizes.defaultSpace,
            Sizes.appBarHeight,
            Sizes.defaultSpace,
            Sizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LoginPageHeader(),
              LoginPageForm(),
              FormDivider(text: 'or sign in with',),
              SizedBox(height: Sizes.spaceBtwSections),
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
