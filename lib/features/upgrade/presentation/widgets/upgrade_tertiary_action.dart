import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpgradeTertiaryAction extends StatelessWidget {
  const UpgradeTertiaryAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          context.go('/home');
        },
        child: Text(
          'Continue with limited access',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
                decoration: TextDecoration.underline,
              ),
        ),
      ),
    );
  }
}
