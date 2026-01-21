import 'package:flutter/material.dart';
import 'dart:ui';
import '../../domain/entities/nav_item.dart';

class BottomNavBar extends StatelessWidget {
  final NavItem activeTab;
  final ValueChanged<NavItem> onTabChange;

  const BottomNavBar({
    super.key,
    required this.activeTab,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    // A map to associate nav items with their icons and labels
    final navItems = {
      NavItem.home: (Icons.home_rounded, 'Home'),
      NavItem.ideas: (Icons.lightbulb_outline_rounded, 'Ideas'),
      NavItem.explore: (Icons.explore_outlined, 'Explore'),
      NavItem.profile: (Icons.person_outline_rounded, 'Profile'),
    };

    return SafeArea(
      top: false, // We only want padding at the bottom
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0), // Reduced bottom padding
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: navItems.entries.map((entry) {
                  final item = entry.key;
                  final icon = entry.value.$1;
                  final label = entry.value.$2;
                  final isActive = activeTab == item;

                  return Expanded(
                    child: _NavItemWidget(
                      icon: icon,
                      label: label,
                      isActive: isActive,
                      onTap: () => onTabChange(item),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItemWidget({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = Colors.indigo[600];
    final inactiveColor = Colors.grey[400];
    
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.indigo.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24.0,
              color: isActive ? activeColor : inactiveColor,
            ),
            const SizedBox(height: 4.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
