import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/product.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/widgets/home_page/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class AddCartAppBar extends StatelessWidget {
  const AddCartAppBar(
      {super.key,
      required this.productId,
      required this.liked,
      required this.variants});
  final String productId;
  final bool liked;
  final List<Variant> variants;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: OurColors.backgroundColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: const Color.fromARGB(255, 242, 242, 245)),
                  child: IconButton(
                    icon: Icon(Iconsax.share, color: OurColors.primaryColor),
                    onPressed: () {
                      // Handle share action
                    },
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: const Color.fromARGB(255, 242, 242, 245)),
                  child: IconButton(
                    icon: FavoriteButton(
                      productId: productId,
                      isLiked: liked,
                    ),
                    onPressed: () {
                      // Handle favorite action
                    },
                  ),
                ),
              ],
            ),
            // Add to Cart button
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OurColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 0),
                  ),
                  onPressed: () {
                    _showAddToCartDialog(context, productId, variants);
                  },
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showAddToCartDialog(
    BuildContext context, String productId, List<Variant> variants) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddToCartDialog(productId: productId, variants: variants);
    },
  );
}

class AddToCartDialog extends StatefulWidget {
  final String productId;
  final List<Variant> variants;

  const AddToCartDialog({required this.productId, required this.variants});

  @override
  _AddToCartDialogState createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
  String? selectedVariant;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Variant and Enter Quantity'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: selectedVariant,
            hint: Text('Select Variant'),
            items: widget.variants.map((Variant variant) {
              return DropdownMenuItem<String>(
                value: variant.productVariantId,
                child: Text(variant.size),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedVariant = newValue;
                quantity = 1; // Reset quantity when variant changes
              });
            },
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (quantity > 1) {
                      quantity--;
                    }
                  });
                },
              ),
              Text('$quantity', style: TextStyle(fontSize: 18)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    if (selectedVariant != null) {
                      Variant selected = widget.variants.firstWhere((variant) =>
                          variant.productVariantId == selectedVariant);
                      if (quantity < selected.quantity) {
                        quantity++;
                      }
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            if (selectedVariant != null) {
              _addToCart(quantity, selectedVariant!);
              Navigator.of(context).pop();
            } else {
              // Show error message
            }
          },
        ),
      ],
    );
  }
}

void _addToCart(int quantity, String productId) async {
  final String url = "api/cart/add";

  final response = await HttpHelper.post(url, {
    'productId': productId,
    'quantity': quantity,
  });
}
