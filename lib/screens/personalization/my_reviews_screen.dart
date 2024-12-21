import 'package:flutter/material.dart';

import '../../widgets/common/appbar.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

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
      body: const Center(
        child: Text('My Reviews Screen'),
      ),
    );
  }
}
