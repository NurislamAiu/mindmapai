import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showFeatureNotImplementedSnackBar(BuildContext context, String featureName) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$featureName is not yet implemented.'),
      duration: const Duration(seconds: 2),
    ),
  );
}

void showDeleteAccountDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Delete Account'),
      content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text('Delete'),
          onPressed: () {
            Navigator.of(context).pop();
            showFeatureNotImplementedSnackBar(context, 'Account Deletion');
          },
        ),
      ],
    ),
  );
}
