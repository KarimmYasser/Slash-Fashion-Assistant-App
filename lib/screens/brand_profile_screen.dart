import 'package:flutter/material.dart';

class BrandProfilePage extends StatefulWidget {
  final String brandName;
  final String brandImage;
  final String brandDescription;

  const BrandProfilePage({
    Key? key,
    required this.brandName,
    required this.brandImage,
    required this.brandDescription,
  }) : super(key: key);

  @override
  _BrandProfilePageState createState() => _BrandProfilePageState();
}

class _BrandProfilePageState extends State<BrandProfilePage> {
  bool isFollowing = false;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brandName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.brandImage),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  widget.brandName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: toggleFollow,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: Text(
                    isFollowing ? 'Following' : 'Follow',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "About the Brand",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.brandDescription,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Gallery",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6, // Replace with actual number of gallery items
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(widget.brandImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
