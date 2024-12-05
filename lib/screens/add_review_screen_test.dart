import 'package:fashion_assistant/screens/add_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AddReviewScreen initial state test',
      (WidgetTester tester) async {
    // Build the AddReviewScreen widget.
    await tester.pumpWidget(MaterialApp(home: AddReviewScreen()));

    // Verify initial state.
    expect(find.text('How satisfied are you with the product overall?'),
        findsOneWidget);
    expect(
        find.text('How would you rate the product quality?'), findsOneWidget);
    expect(find.text('Was the price fair for what you got?'), findsOneWidget);
    expect(find.text('How fast was it the product delivered?'), findsOneWidget);
    expect(find.text('Your review'), findsOneWidget);
    expect(find.text('Upload images (Optional)'), findsOneWidget);
  });

  testWidgets('AddReviewScreen interaction test', (WidgetTester tester) async {
    // Build the AddReviewScreen widget.
    await tester.pumpWidget(MaterialApp(home: AddReviewScreen()));

    // Select ratings for each question.
    for (int i = 0; i < 4; i++) {
      await tester.tap(find
          .byType(IconButton)
          .at(i * 5 + 4)); // Select 5 stars for each question.
      await tester.pump();
    }

    // Enter a review.
    await tester.enterText(
        find.byType(TextField), 'Great product! Highly recommend.');
    await tester.pump();

    // Tap the submit button.
    await tester.tap(find.text('Submit'));
    await tester.pump();

    // Verify that the ratings and review are correctly submitted.
    // Note: In a real test, you would verify the actual submission logic.
    expect(find.text('Great product! Highly recommend.'), findsOneWidget);
  });
}
