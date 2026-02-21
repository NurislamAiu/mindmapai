import 'package:flutter/material.dart';

class HomeSubtitle extends StatelessWidget {
  const HomeSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'What would you like to think through today?',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[600],
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
