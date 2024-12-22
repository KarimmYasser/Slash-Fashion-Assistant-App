import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  // Fetch users from the API
  Future<void> _fetchUsers() async {
    try {
      final response = await HttpHelper.get('api/user');
      setState(() {
        users = response['users'];
        filteredUsers = users; // Initially, show all users
        isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load users: $e')),
        );
      }
    }
  }

  // Filter users based on the search query
  void _filterUsers(String query) {
    setState(() {
      searchQuery = query;
      filteredUsers = users
          .where((user) => '${user['firstName']} ${user['lastName']}'
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  // Block or Unblock user
  Future<void> _toggleBlockUser(String userId, bool isBlocked) async {
    try {
      if (isBlocked) {
        await HttpHelper.post('api/admin/unblock/$userId', {});
      } else {
        await HttpHelper.post('api/admin/block', {
          "comment": "Violation of terms.",
          "id": userId,
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isBlocked ? 'User unblocked' : 'User blocked')),
      );
      _fetchUsers(); // Refresh the users list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user status: $e')),
      );
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
      _fetchUsers(); // Refresh the users list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete review: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterUsers,
              decoration: InputDecoration(
                hintText: 'Search for a user by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // User List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredUsers.isEmpty
                    ? const Center(child: Text('No users found'))
                    : ListView.builder(
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = filteredUsers[index];
                          return UserCard(
                            user: user,
                            onBlockToggle: _toggleBlockUser,
                            onDeleteReview: _deleteReview,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class UserCard extends StatefulWidget {
  final dynamic user;
  final Function(String userId, bool isBlocked) onBlockToggle;
  final Function(String reviewId, String? image) onDeleteReview;

  const UserCard({
    required this.user,
    required this.onBlockToggle,
    required this.onDeleteReview,
    super.key,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool showDetails = false;
  List<dynamic> reviews = [];
  bool isLoadingReviews = false;

  // Fetch reviews for the user
  Future<void> _fetchReviews(String userId) async {
    setState(() {
      isLoadingReviews = true;
    });

    try {
      final response = await HttpHelper.get('api/admin/reviews/$userId');
      setState(() {
        reviews = response[
            'reviews']; // Assuming the endpoint returns a list of reviews
        isLoadingReviews = false;
      });
    } catch (e) {
      setState(() {
        isLoadingReviews = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load reviews: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final isBlocked = user['is_blocked'];

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
            // User Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user['firstName']} ${user['lastName']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Username: ${user['username']}',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'City: ${user['city']}',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Age: ${user['age']}',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          widget.onBlockToggle(user['user_id'], isBlocked),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isBlocked ? Colors.red : OurColors.primaryColor,
                      ),
                      child: Text(isBlocked ? 'Unblock' : 'Block'),
                    ),
                    IconButton(
                      icon: Icon(
                        showDetails
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                      onPressed: () {
                        setState(() {
                          showDetails = !showDetails;
                        });
                        if (showDetails) {
                          // Fetch reviews when expanding
                          _fetchReviews(user['id']);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (showDetails)
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Statistics Section
                    const Text(
                      'Statistics:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    UserStatitics(user: user),
                    const SizedBox(height: Sizes.spaceBtwSections),
                    // Reviews Section
                    const Text(
                      'Reviews:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                          elevation: 3,
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
                                Text(
                                    'Accuracy Rate: ${review['accuracy_rate']}'),
                                Text('Quality Rate: ${review['quality_rate']}'),
                                Text(
                                    'Shipping Rate: ${review['shipping_rate']}'),
                                Text(
                                    'Value for Money Rate: ${review['valueForMoney_rate']}'),
                                const SizedBox(height: 10),

                                // Product Information
                                if (review['product'] != null)
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            if (review['product']
                                                    ['description'] !=
                                                null)
                                              Text(
                                                review['product']
                                                    ['description'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 12),
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
                                      widget.onDeleteReview(
                                          review['id'], review['image']);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class UserStatitics extends StatelessWidget {
  const UserStatitics({super.key, required this.user});

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: PieChart(
            PieChartData(
              sections: _createSections(),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Table(
          border: TableBorder.all(),
          children: [
            _buildTableRow('Total Orders', user['TotalOrders']!),
            _buildTableRow('Total Chats', user['TotalChats']!),
            _buildTableRow('Total Cart Items', user['TotalCartItems']!),
            _buildTableRow('Total Wishlist Items', user['TotalWishlistItems']!),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> _createSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: user['TotalOrders']!.toDouble(),
        title: 'Orders',
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: user['TotalChats']!.toDouble(),
        title: 'Chats',
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: user['TotalCartItems']!.toDouble(),
        title: 'Cart',
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: user['TotalWishlistItems']!.toDouble(),
        title: 'Wishlist',
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  TableRow _buildTableRow(String title, int value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value.toString()),
        ),
      ],
    );
  }
}
