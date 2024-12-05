import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/product_details/rate.dart';
import 'package:fashion_assistant/widgets/product_details/trusted_with_video_reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];
  final TextEditingController _reviewController = TextEditingController();
  final List<int?> _ratings =
      List<int?>.filled(4, null); // Assuming 4 questions
  bool? _recommendProduct;

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _selectedImages.addAll(images);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _submitReview() {
    bool allRated = _ratings.every((rating) => rating != null);
    bool reviewWritten = _reviewController.text.isNotEmpty;
    bool recommendSelected = _recommendProduct != null;

    if (allRated && reviewWritten && recommendSelected) {
      // Handle form submission
      if (_selectedImages.isNotEmpty) {
        for (var image in _selectedImages) {
          print("Image selected: ${image.path}");
        }
      } else {
        print("No images selected");
      }
      print("Review submitted: ${_reviewController.text}");
      print("Recommend product: $_recommendProduct");
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Please rate all questions, write a review, and select if you recommend the product.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColors.secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: OurColors.white,
        centerTitle: true,
        title: const Text("Share Your experience"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RateQuestions(
                onRatingUpdate: (index, rating) {
                  setState(() {
                    _ratings[index] = rating;
                  });
                },
              ),
              SizedBox(height: 16.h),
              // "Your Review" Section
              Text(
                "Your review",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _reviewController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText:
                        'What did you like or dislike? How did you use the product? What should others know before buying?',
                    hintStyle:
                        TextStyle(color: Colors.grey), // Change hint color
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Make border circular
                      borderSide:
                          BorderSide(color: Colors.grey), // Change border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Make border circular
                      borderSide:
                          BorderSide(color: Colors.grey), // Change border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Make border circular
                      borderSide: BorderSide(
                          color:
                              Colors.blue), // Change border color when focused
                    ),
                  ),
                  maxLines: 5,
                ),
              ),
              const SizedBox(height: 16),

              // Enhanced Photo Upload Widget for Multiple Images
              Text(
                "Upload images (Optional)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.grey),
                      const SizedBox(height: 8),
                      Text(
                        "Upload",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Display Selected Images
              if (_selectedImages.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _selectedImages.asMap().entries.map((entry) {
                    int index = entry.key;
                    XFile image = entry.value;

                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(image.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              SizedBox(height: 10.h),
              RecommendProductWidget(
                onRecommendUpdate: (recommend) {
                  setState(() {
                    _recommendProduct = recommend;
                  });
                },
              ),
              const SizedBox(height: 16),
              TrustedWithVideoReviews(),

              SizedBox(height: 10.h),
              // "Submit" Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _submitReview,
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendProductWidget extends StatefulWidget {
  final Function(bool) onRecommendUpdate;

  const RecommendProductWidget({Key? key, required this.onRecommendUpdate})
      : super(key: key);

  @override
  State<RecommendProductWidget> createState() => _RecommendProductWidgetState();
}

class _RecommendProductWidgetState extends State<RecommendProductWidget> {
  String? _selectedOption; // Holds the selected option ("Yes" or "No")

  void _updateSelection(String option) {
    setState(() {
      _selectedOption = option;
    });
    widget.onRecommendUpdate(option == "Yes");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question Text
        const Text(
          "Would You Recommend This Product?",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Yes and No Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // "No" Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedOption == "No"
                    ? Colors.grey[400]
                    : Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _updateSelection("No"),
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 16), // Spacing between buttons

            // "Yes" Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedOption == "Yes"
                    ? Colors.grey[400]
                    : Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _updateSelection("Yes"),
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
