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
    final Color iconBackgroundColor;
    final Color iconColor;
    final Color containerColor;
    final Color borderColor;

    if (isUpgrade) {
      iconBackgroundColor = Colors.indigo.shade100;
      iconColor = Colors.indigo.shade600;
      containerColor = Colors.indigo.shade50.withOpacity(0.5);
      borderColor = Colors.indigo.shade100;
    } else if (isSignOut) {
      iconBackgroundColor = Colors.red.shade50;
      iconColor = Colors.red.shade600;
      containerColor = Colors.white;
      borderColor = Colors.grey.shade200;
    } else {
      iconBackgroundColor = Colors.grey.shade100;
      iconColor = Colors.grey.shade700;
      containerColor = Colors.white;
      borderColor = Colors.grey.shade200;
    }

    return Material(
      color: containerColor,
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: borderColor, width: 1),
          ),
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
                        fontWeight: FontWeight.w500,
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
                  color: isUpgrade ? Colors.indigo.shade400 : Colors.grey.shade400,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
