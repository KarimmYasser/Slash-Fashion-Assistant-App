import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final int discount;
  final String brandName;
  final String category;
  final String material;
  final String imageUrl;
  final List<String> variants;
  final List<dynamic> tags;
  final List<String> colors;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.discount,
    required this.brandName,
    required this.category,
    required this.material,
    required this.imageUrl,
    required this.variants,
    required this.tags,
    required this.colors,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      discount: json['discount'],
      brandName: json['brand']['name'],
      category: json['category']['name'],
      material: json['material'],
      imageUrl: '',
      variants: List<String>.from(json['variants'] ?? []),
      tags: (json['tags'] as List?)?.map((tag) {
            if (tag is Map<String, dynamic>) {
              return tag['name'] ??
                  ''; // Adjust the key as per your API response
            } else if (tag is String) {
              return tag;
            }
            return '';
          }).toList() ??
          [],
      colors: List<String>.from(json['colors'] ?? []),
    );
  }
}

class ApproveProductsScreen extends StatefulWidget {
  const ApproveProductsScreen({super.key});

  @override
  _ApproveProductsScreenState createState() => _ApproveProductsScreenState();
}

class _ApproveProductsScreenState extends State<ApproveProductsScreen> {
  List<Product> products = [];
  bool loading = true;
  Future<void> fetchProducts() async {
    final response = await HttpHelper.get('api/admin/waiting-products');
    setState(() {
      products = (response['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Waiting Products')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? const Center(
                  child: Text('no products found'),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  padding: const EdgeInsets.all(8),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: product,
                            ),
                          ),
                        );
                        fetchProducts(); // Refresh list after returning
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: OurColors.primaryColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8)),
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  Future<void> approveProduct(BuildContext context) async {
    await HttpHelper.get('api/admin/approve-product/${product.id}');
    Navigator.pop(context); // Return to the list screen
  }

  Future<void> rejectProduct(BuildContext context) async {
    await HttpHelper.post('api/admin/reject-product', {
      "id": product.id,
    });
    Navigator.pop(context); // Return to the list screen
  }

  Widget buildDetailCard(String title, List<Widget> content) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 12),
            ...content,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "https://media.istockphoto.com/id/1398610798/photo/young-woman-in-linen-shirt-shorts-and-high-heels-pointing-to-the-side-and-talking.jpg?s=1024x1024&w=is&k=20&c=IdY440I0pLdmANsNZRXhjSS7K9Q-Xxvnwf4YzH9qQbQ=",
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Basic Information
            buildDetailCard(
              'Basic Information',
              [
                _buildDetailRow(
                    'Price', '\$${product.price.toStringAsFixed(2)}'),
                _buildDetailRow('Brand', product.brandName),
                _buildDetailRow('Category', product.category),
                _buildDetailRow('Material', product.material),
                _buildDetailRow('Discount', '${product.discount}%'),
              ],
            ),

            // Description
            buildDetailCard(
              'Description',
              [
                Text(
                  product.description,
                  style: TextStyle(
                      fontSize: 16, height: 1.5, color: Colors.grey.shade700),
                ),
              ],
            ),

            // Tags and Variants

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => approveProduct(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Approve',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => rejectProduct(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Reject',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
