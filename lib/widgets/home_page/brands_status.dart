import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/models/brand.dart';
import 'package:fashion_assistant/screens/brand_list_screen.dart';
import 'package:fashion_assistant/screens/brand_profile_screen.dart';
import 'package:fashion_assistant/services/brand_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandCarousel extends StatefulWidget {
  const BrandCarousel({
    super.key,
  });

  @override
  _BrandCarouselState createState() => _BrandCarouselState();
}

class _BrandCarouselState extends State<BrandCarousel> {
  final Map<String, Color> _dominantColors = {};
  late Future<List<Brand>> _brandsFuture;

  @override
  void initState() {
    super.initState();
    _brandsFuture = BrandService().fetchBrands();
    // _loadDominantColors();
  }

  // Future<void> _loadDominantColors() async {
  //   Map<String, Color> newDominantColors = {};

  //   for (var brand in _brandsFuture) {
  //     final image = NetworkImage(brand['image']!);
  //     final PaletteGenerator generator =
  //         await PaletteGenerator.fromImageProvider(image);
  //     newDominantColors[brand['image']!] =
  //         generator.dominantColor?.color.withOpacity(0.4) ?? Colors.grey;
  //   }

  //   if (mounted) {
  //     setState(() {
  //       _dominantColors.addAll(newDominantColors);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Brand>>(
      future: _brandsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final brands = snapshot.data!;

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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BrandListScreen(),
                          ),
                        ); // Action for "See more"
                      },
                      child: Row(
                        children: [
                          Text(
                            'See more',
                            style: TextStyle(
                                color: OurColors.iconPrimary, fontSize: 16.sp),
                          ),
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
                  itemCount: brands.length,
                  itemBuilder: (context, index) {
                    final brand = brands[index];
                    final dominantColor =
                        _dominantColors[brand.logo] ?? Colors.grey[200];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BrandProfilePage(
                              brandName: brand.name,
                              brandDescription: brand.description,
                              brandImage: brand.logo,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  dominantColor, // Dynamic border color
                              radius:
                                  35, // Size of the circular image container
                              child: CircleAvatar(
                                radius:
                                    30, // Inner circle size (smaller for border effect)
                                backgroundImage: NetworkImage(brand.logo),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              brand.name,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('No brands available'),
          );
        }
      },
    );
  }
}
