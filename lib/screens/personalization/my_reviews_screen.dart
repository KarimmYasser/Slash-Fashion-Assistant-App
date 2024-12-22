import 'package:fashion_assistant/data/authentication.repository/login_data.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/http/http_client.dart';
import '../../widgets/common/appbar.dart';

class MyReviewsScreen extends StatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  List<dynamic> reviews = [];
  bool isLoadingReviews = false;

  Future<void> _fetchReviews(String userId) async {
    setState(() {
      isLoadingReviews = true;
    });

    try {
      final response = await HttpHelper.get('api/review');
      reviews = response[
          'reviews']; // Assuming the endpoint returns a list of reviews
      isLoadingReviews = false;
    } catch (e) {
      setState(() {
        isLoadingReviews = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load reviews: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  // Delete a review
  Future<void> _deleteReview(String reviewId, String? image) async {
    try {
      if (image != null) {
        await HttpHelper.delete('api/review/image', {"reviewId": reviewId});
      }
      await HttpHelper.delete('api/review/$reviewId', {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review deleted successfully')),
      );
      _fetchReviews(UserData.userData!.id!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete review: $e')),
      );
    }
  }

  @override
  initState() {
    super.initState();
    _fetchReviews(UserData.userData!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbar(
          title: Text(
            'My Reviews',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          showBackButton: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                if (isLoadingReviews)
                  const Center(child: CircularProgressIndicator())
                else if (reviews.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(Sizes.defaultSpace),
                    child: Center(child: Text('No reviews found')),
                  )
                else
                  ...reviews.map<Widget>((review) {
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 10),
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Review Comment
                            if (review['comment'] != null)
                              Text(
                                'Comment: ${review['comment']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            const SizedBox(height: 5),

                            // Review Ratings
                            Text('Rating: ${review['rating']}'),
                            Text('Accuracy Rate: ${review['accuracy_rate']}'),
                            Text('Quality Rate: ${review['quality_rate']}'),
                            Text('Shipping Rate: ${review['shipping_rate']}'),
                            Text(
                                'Value for Money Rate: ${review['valueForMoney_rate']}'),
                            const SizedBox(height: 10),

                            // Product Information
                            if (review['product'] != null)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Image
                                  if (review['product']['image'] != null)
                                    Image.network(
                                      review['product']['image'],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  const SizedBox(width: 10),

                                  // Product Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review['product']['name'] ??
                                              'No product name',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            'Price: \$${review['product']['price']}'),
                                        Text(
                                            'Material: ${review['product']['material']}'),
                                        Text(
                                            'Rating: ${review['product']['rating']}'),
                                        if (review['product']['description'] !=
                                            null)
                                          Text(
                                            review['product']['description'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 10),

                            // Delete Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: const Icon(Icons.delete,
                                    color: OurColors.primaryColor),
                                onPressed: () {
                                  _deleteReview(review['id'], review['image']);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
              ],
            ),
          ),
        ));
  }
}
