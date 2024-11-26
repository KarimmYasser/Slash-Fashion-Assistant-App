import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLiked = !_isLiked;
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: _isLiked
            ? const Icon(
                Iconsax.heart5,
                key: ValueKey('liked'),
                color: OurColors.primaryColor,
                size: Sizes.iconMd,
              )
            : const Icon(
                Iconsax.heart,
                key: ValueKey('unliked'),
                color: OurColors.primaryColor,
                size: Sizes.iconMd,
              ),
      ),
    );
  }
}
