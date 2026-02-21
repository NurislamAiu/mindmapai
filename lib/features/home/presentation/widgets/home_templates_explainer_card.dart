import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeTemplatesExplainerCard extends StatelessWidget {
  const HomeTemplatesExplainerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: const Row(
        children: [
          Icon(
            Iconsax.document_favorite,
            color: Color(0xFF6366F1),
            size: 28,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Why use templates?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Get a head start with proven structures.',
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
