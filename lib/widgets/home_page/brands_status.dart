import 'package:flutter/material.dart';

class BrandCarousel extends StatelessWidget {
  const BrandCarousel({
    super.key,
    required this.brands,
  });
  final List<Map<String, String>> brands;

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
              Text(
                'Brands',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // Action for "See more"
                },
                child: Row(
                  children: [
                    Text('See more', style: TextStyle(color: Colors.grey)),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 100, // Adjust height for circular avatars
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200], // Border color
                      radius: 35, // Size of the circular image container
                      child: CircleAvatar(
                        radius:
                            32, // Inner circle size (smaller for border effect)
                        backgroundImage: AssetImage(brands[index]['image']!),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      brands[index]['name']!,
                      style: TextStyle(fontSize: 12),
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
