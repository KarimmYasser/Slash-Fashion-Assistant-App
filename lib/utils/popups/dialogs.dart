import 'package:flutter/material.dart';

class Dialogs {
  static defaultDialog({
    required BuildContext context,
    String title = 'Removal Confirmation',
    String content = 'Removing this data will delete all related data. Are you sure?',
    String cancelText = 'Cancel',
    String confirmText = 'Remove',
    Function()? onCancel,
    Function()? onConfirm,
  }) {
    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: onConfirm,
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}
