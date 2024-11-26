import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

class BrandCarousel extends StatefulWidget {
  const BrandCarousel({
    super.key,
    required this.brands,
  });
  final List<Map<String, String>> brands;

  @override
  _BrandCarouselState createState() => _BrandCarouselState();
}

class _BrandCarouselState extends State<BrandCarousel> {
  final Map<String, Color> _dominantColors = {};

  @override
  void initState() {
    super.initState();
    _loadDominantColors();
  }

  Future<void> _loadDominantColors() async {
    Map<String, Color> newDominantColors = {};

    for (var brand in widget.brands) {
      final image = NetworkImage(brand['image']!);
      final PaletteGenerator generator =
          await PaletteGenerator.fromImageProvider(image);
      newDominantColors[brand['image']!] =
          generator.dominantColor?.color.withOpacity(0.4) ?? Colors.grey;
    }

    if (mounted) {
      setState(() {
        _dominantColors.addAll(newDominantColors);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Brands',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // Action for "See more"
                },
                child: Row(
                  children: [
                    Text('See more',
                        style: TextStyle(
                            color: OurColors.iconPrimary, fontSize: 16.sp)),
                    Icon(Icons.arrow_forward_ios,
                        size: 16.sp, color: OurColors.iconPrimary),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 100, // Adjust height for circular avatars
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.brands.length,
            itemBuilder: (context, index) {
              final brand = widget.brands[index];
              final dominantColor =
                  _dominantColors[brand['image']!] ?? Colors.grey[200];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: dominantColor, // Dynamic border color
                      radius: 35, // Size of the circular image container
                      child: CircleAvatar(
                        radius:
                            30, // Inner circle size (smaller for border effect)
                        backgroundImage: NetworkImage(brand['image']!),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      brand['name']!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
