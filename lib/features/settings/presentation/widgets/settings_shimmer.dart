import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SettingsShimmer extends StatelessWidget {
  const SettingsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildShimmerContainer(height: 20, width: 250),
            const SizedBox(height: 24),
            _buildProfileShimmer(),
            const SizedBox(height: 24),
            _buildSettingsGroupShimmer(itemCount: 4),
            const SizedBox(height: 24),
            _buildSettingsGroupShimmer(itemCount: 2),
            const SizedBox(height: 24),
            _buildSettingsGroupShimmer(itemCount: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerContainer({required double height, double width = double.infinity, double borderRadius = 8.0}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  Widget _buildProfileShimmer() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildShimmerContainer(height: 52, width: 52, borderRadius: 26),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerContainer(height: 20, width: 120),
                  const SizedBox(height: 8),
                  _buildShimmerContainer(height: 16, width: 180),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          _buildShimmerContainer(height: 50, borderRadius: 16),
        ],
      ),
    );
  }

  Widget _buildSettingsGroupShimmer({required int itemCount}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerContainer(height: 16, width: 100),
        const SizedBox(height: 12),
        Container(
           decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: List.generate(itemCount, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                     _buildShimmerContainer(height: 40, width: 40, borderRadius: 20),
                     const SizedBox(width: 16),
                     _buildShimmerContainer(height: 20, width: 150),
                     const Spacer(),
                     _buildShimmerContainer(height: 16, width: 16),
                  ],
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
