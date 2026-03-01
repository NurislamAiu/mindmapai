import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class AICreditsActionSection extends StatelessWidget {
  final VoidCallback? onGetCredits;
  final VoidCallback? onGoPro;

  const AICreditsActionSection({
    super.key,
    this.onGetCredits,
    this.onGoPro,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 400;

        Widget getCreditsBtn = ElevatedButton(
          onPressed: onGetCredits,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4F46E5), // indigo-600
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.card, size: 20),
              Gap(12),
              Text(
                'Get credits',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );

        Widget goProBtn = ElevatedButton(
          onPressed: onGoPro,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey[900],
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.crown, size: 20, color: Color(0xFF4F46E5)),
              Gap(12),
              Text(
                'Go Pro',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );

        if (isSmallScreen) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getCreditsBtn,
              const Gap(12),
              goProBtn,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: getCreditsBtn),
            const Gap(12),
            Expanded(child: goProBtn),
          ],
        );
      },
    );
  }
}
