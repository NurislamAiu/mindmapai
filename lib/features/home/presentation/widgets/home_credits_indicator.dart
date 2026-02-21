import 'package:flutter/material.dart';

class HomeCreditsIndicator extends StatelessWidget {
  final int creditCount;

  const HomeCreditsIndicator({super.key, required this.creditCount});

  @override
  Widget build(BuildContext context) {
    return Text(
      'You have $creditCount AI ${creditCount == 1 ? 'credit' : 'credits'}',
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey[400],
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
