import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';

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
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: _isLiked
            ? Icon(
                Icons.favorite,
                key: ValueKey('liked'),
                color: OurColors.primaryColor,
                size: 28,
              )
            : Icon(
                Icons.favorite_border,
                key: ValueKey('unliked'),
                color: Colors.grey,
                size: 28,
              ),
      ),
    );
  }
}
