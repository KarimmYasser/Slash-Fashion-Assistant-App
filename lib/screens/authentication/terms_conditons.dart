import '../../constants.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool _isTermsAndConditionsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _isTermsAndConditionsChecked,
            onChanged: (bool? value) {
              setState(() {
                          _isTermsAndConditionsChecked = value ?? false;
                        });
            },
          ),
        ),
        const SizedBox(width: Sizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: "I agree to ",
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: "Privacy Policy ",
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: OurColors.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: OurColors.primaryColor,
                    ),
              ),
              TextSpan(
                  text: "and ", style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: "Terms of use.",
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: OurColors.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: OurColors.primaryColor,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
