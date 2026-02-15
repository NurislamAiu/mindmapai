import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({super.key, this.size = 20.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icon/google.svg',
      width: size,
      height: size,
    );
  }
}
