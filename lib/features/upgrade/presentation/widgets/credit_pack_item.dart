import 'package:flutter/material.dart';
import 'package:mindmapai/features/upgrade/domain/entities/credit_pack_entity.dart';

class CreditPackItem extends StatelessWidget {
  final CreditPackEntity pack;
  final bool isSelected;
  final VoidCallback onTap;

  const CreditPackItem({
    super.key,
    required this.pack,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: isSelected ? Colors.indigo.shade400 : Colors.grey.shade200,
                width: isSelected ? 2.0 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected ? Colors.indigo.shade50.withOpacity(0.8) : Colors.grey.shade100.withOpacity(0.6),
                  blurRadius: 15,
                  spreadRadius: -2,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${pack.credits} Credits',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pack.description,
                        style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  pack.price,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(width: 16),
                // Индикатор выбора
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.indigo.shade600 : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? Colors.indigo.shade600 : Colors.grey.shade300,
                      width: 2.0,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ],
            ),
          ),
          // Премиальный бейдж
          if (pack.isMostPopular)
            Positioned(
              top: 12,
              right: -4,
              child: AnimatedOpacity(
                opacity: isSelected ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'POPULAR',
                    style: textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
