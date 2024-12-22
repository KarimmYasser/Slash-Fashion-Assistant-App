import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Future<Map<String, dynamic>> fetchStatistics() async {
    const url = 'api/analysis/statistics';
    final response = await HttpHelper.get(url);
    return response;
  }

  // Helper function to format titles
  String formatTitle(String key) {
    String formatted = key.replaceFirst('total', ''); // Remove 'total'
    return formatted.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'), // Add space before capital letters
      (match) => '${match.group(1)} ${match.group(2)}',
    );
  }

  // Categorize data into sections
  Map<String, List<Map<String, dynamic>>> categorizeData(
      Map<String, dynamic> data) {
    Map<String, List<Map<String, dynamic>>> categories = {
      'Users': [],
      'Brands': [],
      'Products': [],
      'Orders': [],
      'Cart': [],
      'Admin': [],
      'Product Details': [],
      'Misc': [],
    };

    data.forEach((key, value) {
      if (key.contains('User')) {
        categories['Users']!.add({'key': key, 'value': value});
      } else if (key.contains('Brand')) {
        categories['Brands']!.add({'key': key, 'value': value});
      } else if (key.contains('Product')) {
        categories['Products']!.add({'key': key, 'value': value});
      } else if (key.contains('Order')) {
        categories['Orders']!.add({'key': key, 'value': value});
      } else if (key.contains('Cart')) {
        categories['Cart']!.add({'key': key, 'value': value});
      } else if (key.contains('Admin')) {
        categories['Admin']!.add({'key': key, 'value': value});
      } else if (key.contains('Detail') || key.contains('Specification')) {
        categories['Product Details']!.add({'key': key, 'value': value});
      } else {
        categories['Misc']!.add({'key': key, 'value': value});
      }
    });

    return categories;
  }

  // Helper function to assign unique icons
  IconData getIconForKey(String key) {
    if (key.contains('User')) return Icons.person;
    if (key.contains('Brand')) return Icons.business;
    if (key.contains('Product')) return Icons.shopping_bag;
    if (key.contains('Order')) return Icons.receipt;
    if (key.contains('Cart')) return Icons.shopping_cart;
    if (key.contains('Admin')) return Icons.admin_panel_settings;
    if (key.contains('Detail') || key.contains('Specification')) {
      return Icons.description;
    }
    return Icons.info;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchStatistics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final categorizedData = categorizeData(data);

            return ListView(
              padding: const EdgeInsets.all(10),
              children: categorizedData.entries.map((category) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        category.key,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Section Cards
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: category.value.map((item) {
                        return StatisticsCard(
                          title: formatTitle(item['key']),
                          value: item['value'].toString(),
                          icon:
                              getIconForKey(item['key']), // Assign unique icon
                        );
                      }).toList(),
                    ),
                  ],
                );
              }).toList(),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class StatisticsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatisticsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const CircleBorder(
        side: BorderSide(
            color: OurColors.primaryColor, width: 2), // Circular border
      ),
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 40,
                color: OurColors.primaryColor), // Primary color for icon

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
