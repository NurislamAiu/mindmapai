import 'dart:math' as math;
import 'package:flutter/material.dart';

class ProfileMenuItem extends StatefulWidget {
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
  State<ProfileMenuItem> createState() => _ProfileMenuItemState();
}

class _ProfileMenuItemState extends State<ProfileMenuItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shineController;

  @override
  void initState() {
    super.initState();
    if (widget.isUpgrade) {
      _shineController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
      )..repeat();
    }
  }

  @override
  void dispose() {
    if (widget.isUpgrade) {
      _shineController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Define colors and decorations based on type
    Color iconBackgroundColor;
    Color iconColor;
    Color titleColor;
    Color subtitleColor;
    Color chevronColor;
    Decoration? containerDecoration;
    List<BoxShadow>? boxShadow;

    if (widget.isUpgrade) {
      containerDecoration = BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B21B6), Color(0xFF4C1D95)], // From HomePrimaryActionCard
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
      );
      boxShadow = [
        BoxShadow(
          color: const Color(0xFF5B21B6).withOpacity(0.4),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];
      iconBackgroundColor = Colors.white.withOpacity(0.1);
      iconColor = Colors.white;
      titleColor = Colors.white;
      subtitleColor = Colors.white.withOpacity(0.8);
      chevronColor = Colors.white70;
    } else {
      // Common style for regular and sign-out items
      containerDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      );
      boxShadow = [
        BoxShadow(
          color: Colors.grey.shade200.withOpacity(0.6),
          blurRadius: 15,
          offset: const Offset(0, 4),
        ),
      ];

      if (widget.isSignOut) {
        iconBackgroundColor = Colors.red.shade50;
        iconColor = Colors.red.shade600;
        titleColor = Colors.red.shade700;
      } else {
        iconBackgroundColor = Colors.grey.shade100;
        iconColor = Colors.grey.shade700;
        titleColor = Colors.grey.shade900;
      }
      subtitleColor = Colors.grey.shade600;
      chevronColor = Colors.grey.shade400;
    }

    final content = Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconBackgroundColor,
            borderRadius: BorderRadius.circular(16.0),
            border: widget.isUpgrade
                ? Border.all(color: Colors.white.withOpacity(0.15))
                : null,
          ),
          child: Icon(widget.icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: textTheme.bodyLarge?.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (widget.subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  widget.subtitle!,
                  style: textTheme.bodyMedium?.copyWith(color: subtitleColor),
                ),
              ],
            ],
          ),
        ),
        if (!widget.isSignOut)
          Icon(
            Icons.chevron_right_rounded,
            color: chevronColor,
          ),
      ],
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(20.0),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: containerDecoration,
            child: widget.isUpgrade
                ? Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: _shineController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                -200 + (_shineController.value * 500),
                                -100,
                              ),
                              child: Transform.rotate(
                                angle: -math.pi / 5,
                                child: Container(
                                  width: 100,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.0),
                                        Colors.white.withOpacity(0.12),
                                        Colors.white.withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      content,
                    ],
                  )
                : content,
          ),
        ),
      ),
    );
  }
}
