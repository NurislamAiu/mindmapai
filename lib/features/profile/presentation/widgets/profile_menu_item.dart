import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isUpgrade;
  final bool isSignOut;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isUpgrade = false,
    this.isSignOut = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Define colors based on type
    Color iconBackgroundColor;
    Color iconColor;
    List<BoxShadow>? boxShadow;
    Decoration? containerDecoration;

    if (isUpgrade) {
      iconBackgroundColor = Colors.white;
      iconColor = Colors.indigo.shade600;
      containerDecoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo.shade50.withOpacity(0.4),
            Colors.purple.shade50.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.white)
      );
    } else {
      // Common style for regular and sign-out items
      boxShadow = [
        BoxShadow(
          color: Colors.grey.shade200.withOpacity(0.6),
          blurRadius: 15,
          offset: const Offset(0, 4),
        ),
      ];
      containerDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      );

      if (isSignOut) {
        iconBackgroundColor = Colors.red.shade50;
        iconColor = Colors.red.shade600;
      } else {
        iconBackgroundColor = Colors.grey.shade100;
        iconColor = Colors.grey.shade700;
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.0),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: containerDecoration,
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textTheme.bodyLarge?.copyWith(
                          color: isSignOut ? Colors.red.shade700 : Colors.grey[900],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ],
                  ),
                ),
                if (!isSignOut)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: isUpgrade ? Colors.indigo.shade500 : Colors.grey.shade400,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
