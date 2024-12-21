import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApproveBrandsScreen extends StatefulWidget {
  const ApproveBrandsScreen({super.key});

  @override
  State<ApproveBrandsScreen> createState() => _ApproveBrandsScreenState();
}

class _ApproveBrandsScreenState extends State<ApproveBrandsScreen> {
  List<dynamic> brands = [];
  List<dynamic> filteredBrands = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchBrands();
  }

  // Fetch brands from the API
  Future<void> _fetchBrands() async {
    try {
      final response = await HttpHelper.get('api/brand');
      setState(() {
        brands = response['brands'];
        filteredBrands = brands; // Initially, show all brands
        isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load brands: $e')),
        );
      }
    }
  }

  // Filter brands based on the search query
  void _filterBrands(String query) {
    setState(() {
      searchQuery = query;
      filteredBrands = brands
          .where((brand) =>
              brand['name'] != null &&
              brand['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Block or Unblock brand
  Future<void> _toggleBlockBrand(String brandId, bool isBlocked) async {
    try {
      if (isBlocked) {
        await HttpHelper.post('api/admin/unblock/$brandId', {});
      } else {
        await HttpHelper.post('api/admin/block', {
          "comment": "Violation of terms.",
          "id": brandId,
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(isBlocked ? 'Brand unblocked' : 'Brand blocked')),
      );
      _fetchBrands(); // Refresh the brands list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update brand status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brands'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterBrands,
              decoration: InputDecoration(
                hintText: 'Search for a brand...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Brand List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredBrands.isEmpty
                    ? const Center(child: Text('No brands found'))
                    : ListView.builder(
                        itemCount: filteredBrands.length,
                        itemBuilder: (context, index) {
                          final brand = filteredBrands[index];
                          return BrandCard(
                            brand: brand,
                            onBlockToggle: _toggleBlockBrand,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class BrandCard extends StatelessWidget {
  final dynamic brand;
  final Function(String brandId, bool isBlocked) onBlockToggle;

  const BrandCard({
    required this.brand,
    required this.onBlockToggle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isBlocked = brand['is_blocked'];

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand['name'] ?? 'Unknown Brand',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Rating: ${brand['rating']}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      'Phone: ${brand['phone']}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => onBlockToggle(brand['user_id'], isBlocked),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isBlocked ? Colors.red : OurColors.primaryColor,
                  ),
                  child: Text(isBlocked ? 'Unblock' : 'Block'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Brand Description
            Text(
              brand['description'] ?? 'No description available',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
