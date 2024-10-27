import '../../constants.dart';
import 'package:flutter/material.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Flexible(
          child: Divider(
              color: OurColors.darkGrey,
              thickness: 0.5,
              indent: 60,
              endIndent: 5),
        ),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
        const Flexible(
          child: Divider(
              color: OurColors.darkGrey,
              thickness: 0.5,
              indent: 5,
              endIndent: 60),
        ),
      ],
    );
  }
}
