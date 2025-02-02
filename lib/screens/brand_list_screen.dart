import 'package:fashion_assistant/models/brand.dart';
import 'package:fashion_assistant/services/brand_service.dart';
import 'package:flutter/material.dart';

class BrandListScreen extends StatefulWidget {
  const BrandListScreen({super.key});

  @override
  _BrandListScreenState createState() => _BrandListScreenState();
}

class _BrandListScreenState extends State<BrandListScreen> {
  late Future<List<Brand>> _brandsFuture;

  @override
  void initState() {
    super.initState();
    _brandsFuture = BrandService().fetchBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brands'),
      ),
      body: FutureBuilder<List<Brand>>(
        future: _brandsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final brands = snapshot.data!;

            return ListView.builder(
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final brand = brands[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(brand.logo),
                    ),
                    title: Text(brand.name),
                    subtitle: Text(brand.description),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text(brand.rating.toString()),
                      ],
                    ),
                    onTap: () {
                      _showBrandDetails(context, brand);
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No brands found.'));
          }
        },
      ),
    );
  }

  void _showBrandDetails(BuildContext context, Brand brand) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(brand.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(brand.logo),
              const SizedBox(height: 8),
              Text('Description: ${brand.description}'),
              const SizedBox(height: 8),
              Text('Email: ${brand.email}'),
              Text('Phone: ${brand.phone}'),
              Text('Facebook: ${brand.facebook}'),
              Text('Instagram: ${brand.instagram}'),
              Text('Website: ${brand.website}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
