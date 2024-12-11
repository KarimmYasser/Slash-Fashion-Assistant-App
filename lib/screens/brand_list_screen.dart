import 'package:fashion_assistant/models/brand.dart';
import 'package:fashion_assistant/services/brand_service.dart';
import 'package:flutter/material.dart';

class BrandListScreen extends StatefulWidget {
  @override
  _BrandListScreenState createState() => _BrandListScreenState();
}

class _BrandListScreenState extends State<BrandListScreen> {
  late Future<BrandsResponse> _brandsFuture;

  @override
  void initState() {
    super.initState();
    _brandsFuture = BrandService().fetchBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brands'),
      ),
      body: FutureBuilder<BrandsResponse>(
        future: _brandsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final brands = snapshot.data!.brands;

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
                        Icon(Icons.star, color: Colors.amber),
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
            return Center(child: Text('No brands found.'));
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
              SizedBox(height: 8),
              Text('Description: ${brand.description}'),
              SizedBox(height: 8),
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
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
