import 'package:flutter/material.dart';

class MindMapLogo extends StatelessWidget {
  const MindMapLogo({super.key, this.size = 120.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icon/icon.png',
      width: size,
      height: size,
    );
  }
}
