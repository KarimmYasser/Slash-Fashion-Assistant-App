import 'package:fashion_assistant/screens/authentication/verify_email.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../screens/authentication/terms_conditons.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.user),
                    label: Text('First Name',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ),
              const SizedBox(width: Sizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.user),
                    label: Text('Last Name',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.user_edit),
              label: Text('Username',
                  style: Theme.of(context).textTheme.bodyLarge),
              hintText: 'Enter a unique username',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.direct),
              label:
                  Text('E-Mail', style: Theme.of(context).textTheme.bodyLarge),
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.call),
              label: Text('Phone Number',
                  style: Theme.of(context).textTheme.bodyLarge),
              hintText: 'Enter your phone number',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            obscureText: !_isPasswordVisible,
            expands: false,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                icon:
                    Icon(_isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              label: Text('Password',
                  style: Theme.of(context).textTheme.bodyLarge),
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwSections),
          const TermsAndConditions(),
          const SizedBox(height: Sizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final response = await HttpHelper.post('api/auth/signup', {
                  'email': 'karim@example.com',
                  'username': 'karimmyasserr',
                  'password': 'k01234444',
                  "role": "SHOPPER",
                  "phone": "+201144432284",
                  "image": "http://karim.com/image.jpg",
                  "city": "ASWAN",
                  "preferences": {
                    "preference1": "bahb elbahr",
                    "preference2": "amoot ana w a3eed elsana",
                  }
                });
                print(response);
                Get.off(() => const VerifyEmailScreen());
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.buttonHeight / 3),
                child: Text(
                  'Create Account',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
