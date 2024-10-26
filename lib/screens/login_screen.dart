import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Sizes.defaultSpace,
            Sizes.appBarHeight,
            Sizes.defaultSpace,
            Sizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/logo/logo_black.png',
                    height: Sizes.logoheight,
                  ),
                  Text('Fashion Assistant',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: Sizes.sm),
                  Text(
                    'Discover Your Unique Style.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Sizes.spaceBtwSections),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: 'Email',
                          hintText: 'Enter your email',
                        ),
                      ),
                      const SizedBox(height: Sizes.spaceBtwInputFields),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          suffixIcon: Icon(Iconsax.eye_slash),
                        ),
                      ),
                      const SizedBox(height: Sizes.spaceBtwInputFields / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Checkbox(value: true, onChanged: (bool? value) {}),
                              const Text('Remember me'),
                            ],
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password?')),
                        ],
                      ),
                      const SizedBox(height: Sizes.spaceBtwInputFields),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Sign in')),
                      ),
                      const SizedBox(height: Sizes.spaceBtwItems),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Create Account')),
                      ),
                    ],
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 5),
                  ),
                  Text('or sign in with'),
                  Flexible(
                    child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
