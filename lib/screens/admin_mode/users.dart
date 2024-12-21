import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<dynamic> users = [];
  bool isLoading = true;

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
  Future<void> _deleteReview(String reviewId) async {
    try {
      await HttpHelper.delete('api/review/image', {"reviewId": reviewId});
      await HttpHelper.delete('api/review/$reviewId', {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review deleted successfully')),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? const Center(child: Text('No users found'))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return UserCard(
                      user: user,
                      onBlockToggle: _toggleBlockUser,
                      onDeleteReview: _deleteReview,
                    );
                  },
                ),
    );
  }
}

class UserCard extends StatefulWidget {
  final dynamic user;
  final Function(String userId, bool isBlocked) onBlockToggle;
  final Function(String reviewId) onDeleteReview;

  const UserCard({
    required this.user,
    required this.onBlockToggle,
    required this.onDeleteReview,
    Key? key,
  }) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool showReviews = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final isBlocked = user['is_blocked'];
    final reviews = user['reviews'] ?? [];

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
                          widget.onBlockToggle(user['id'], isBlocked),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isBlocked ? Colors.white : OurColors.primaryColor,
                      ),
                      child: Text(isBlocked ? 'Unblock' : 'Block'),
                    ),
                    IconButton(
                      icon: Icon(
                        showReviews
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                      onPressed: () {
                        setState(() {
                          showReviews = !showReviews;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Reviews Section
            if (showReviews)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reviews:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...reviews.map<Widget>((review) {
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 10),
                      elevation: 3,
                      child: ListTile(
                        title: Text(review['content'] ?? 'No content'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete,
                              color: OurColors.primaryColor),
                          onPressed: () {
                            widget.onDeleteReview(review['id']);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
