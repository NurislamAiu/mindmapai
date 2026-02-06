import 'package:flutter/material.dart';
import 'package:mindmapai/features/upgrade/domain/entities/pro_plan_entity.dart';

class PlanSelectionCard extends StatelessWidget {
  final ProPlanEntity plan;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanSelectionCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: isSelected ? Colors.indigo.shade400 : Colors.grey.shade200,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.indigo.shade100,
                    blurRadius: 18,
                    spreadRadius: -2,
                    offset: const Offset(0, 6),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            // Plan details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        plan.title,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      if (plan.badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.purple.shade600 : Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            plan.badge!,
                            style: textTheme.labelSmall?.copyWith(
                              color: isSelected ? Colors.white : Colors.purple.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        plan.price,
                        style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          plan.billingCycle,
                          style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Radio button indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.indigo.shade600 : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.indigo.shade600 : Colors.grey.shade300,
                  width: 2.5,
                ),
              ),
              child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 18) : null,
            ),
          ],
        ),
      ),
    );
  }
}
