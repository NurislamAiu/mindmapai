import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MindMapLogo extends StatelessWidget {
  const MindMapLogo({super.key, this.size = 120.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icon/icon_svg.svg',
      width: size,
      height: size,
    );
  }
}
