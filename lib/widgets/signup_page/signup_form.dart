import '../../constants.dart';
import '../../screens/authentication/terms_conditons.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

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
            expands: false,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: const Icon(Iconsax.eye_slash),
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
              onPressed: () {},
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
