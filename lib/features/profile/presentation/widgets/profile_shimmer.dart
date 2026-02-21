import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Shimmer for ProfileHeader (approximated)
                  _buildShimmerContainer(height: 36),
                  const SizedBox(height: 24.0),
                  // Shimmer for ProfileCard
                  _buildShimmerProfileCard(),
                  const SizedBox(height: 24.0),
                  // Shimmer for MenuItems
                  _buildShimmerMenuItem(isUpgrade: true),
                  const SizedBox(height: 8.0),
                  _buildShimmerMenuItem(),
                  const SizedBox(height: 8.0),
                  _buildShimmerMenuItem(),
                  const SizedBox(height: 8.0),
                  _buildShimmerMenuItem(),
                  const SizedBox(height: 24.0),
                  // Shimmer for ProfileStatsCard (approximated)
                  _buildShimmerContainer(height: 90, borderRadius: 28),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerContainer({
    required double height,
    double? width,
    double borderRadius = 16.0,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  Widget _buildShimmerProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: Row(
        children: [
          _buildShimmerContainer(height: 56, width: 56, borderRadius: 20.0),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerContainer(height: 24, width: 180),
                const SizedBox(height: 8),
                _buildShimmerContainer(height: 16, width: 220),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerMenuItem({bool isUpgrade = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          _buildShimmerContainer(height: 44, width: 44, borderRadius: 16.0),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildShimmerContainer(height: 18, width: 120),
                const SizedBox(height: 6),
                _buildShimmerContainer(height: 14, width: 180),
              ],
            ),
          ),
          const SizedBox(width: 16),
           _buildShimmerContainer(height: 24, width: 24),
        ],
      ),
    );
  }
}
