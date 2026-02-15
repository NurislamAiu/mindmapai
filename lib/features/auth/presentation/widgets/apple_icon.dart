import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppleIcon extends StatelessWidget {
  const AppleIcon({super.key, this.size = 20.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icon/apple.svg',
      width: size,
      height: size,
    );
  }
}
