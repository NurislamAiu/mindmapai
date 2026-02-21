import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final Color? color;
  final Color? iconContainerColor;

  const SettingItem({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    required this.onTap,
    this.color,
    this.iconContainerColor,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = iconContainerColor ?? Colors.grey.shade100;

    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      borderRadius: BorderRadius.circular(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    baseColor.withOpacity(0.7),
                    baseColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: baseColor.withOpacity(0.6),
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 5,
                    offset: Offset(-3, -3),
                  ),
                ],
              ),
              child: Icon(icon, color: color ?? Colors.grey.shade600, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: color, fontWeight: FontWeight.w400),
              ),
            ),
            if (value != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  value!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.w300),
                ),
              ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
