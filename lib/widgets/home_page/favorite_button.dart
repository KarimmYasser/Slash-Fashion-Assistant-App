import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fashion_assistant/constants.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.productId});
  final String productId;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isLiked = false;
  bool _isLoading = false;

  Future<void> _updateFavoriteStatus() async {
    final String url = _isLiked ? 'api/wishlist/remove' : 'api/wishlist/add';

    setState(() {
      _isLoading = true;
    });

    try {
      final response =
          await HttpHelper.post(url, {'productId': widget.productId});

      debugPrint('Response status: ${response['statusCode']}');

      setState(() {
        _isLiked = !_isLiked;
      });
    } catch (e) {
      debugPrint('Error: ${widget.productId} $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading ? null : _updateFavoriteStatus,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: _isLoading
            ? const SizedBox(
                key: ValueKey('loading'),
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: OurColors.primaryColor,
                ),
              )
            : _isLiked
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
