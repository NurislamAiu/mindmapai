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
    final navItems = {
      NavItem.home: (Icons.home_rounded, 'Home'),
      NavItem.ideas: (Icons.lightbulb_outline_rounded, 'Ideas'),
      NavItem.explore: (Icons.explore_outlined, 'Explore'),
      NavItem.profile: (Icons.person_outline_rounded, 'Profile'),
    };

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    left: (MediaQuery.of(context).size.width - 32) / navItems.length * activeTab.index,
                    top: 0,
                    bottom: 0,
                    width: (MediaQuery.of(context).size.width - 32) / navItems.length,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(26.0),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: navItems.entries.map((entry) {
                      final item = entry.key;
                      final icon = entry.value.$1;
                      final label = entry.value.$2;
                      return Expanded(
                        child: _NavItemWidget(
                          icon: icon,
                          label: label,
                          isActive: activeTab == item,
                          onTap: () => onTabChange(item),
                        ),
                      );
                    }).toList(),
                  ),
                ],
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
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: isActive ? 1.0 : 0.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Icon(
                  icon,
                  size: 24.0,
                  color: Color.lerp(inactiveColor, activeColor, value),
                );
              },
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: isActive ? 1.0 : 0.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value * 2),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.lerp(FontWeight.normal, FontWeight.bold, value),
                      color: Color.lerp(inactiveColor, activeColor, value),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
