import '../../widgets/signup_page/signup_form.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Let's create your account",
            style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              SignUpForm(),
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
