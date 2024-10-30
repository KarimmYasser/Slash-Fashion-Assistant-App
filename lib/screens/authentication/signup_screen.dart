import '../../widgets/signup_page/signup_form.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Text("Let's create your account",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: Sizes.spaceBtwSections),
              const SignUpForm(),
              //const SizedBox(height: Sizes.spaceBtwSections),
              //const FormDivider(text: 'or sign up with',),
              //const SizedBox(height: Sizes.spaceBtwSections),
              //const SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}

