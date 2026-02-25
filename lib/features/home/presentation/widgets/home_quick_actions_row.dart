import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

/// A row of quick action buttons for the home screen.
class HomeQuickActionsRow extends StatelessWidget {
  const HomeQuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            icon: Iconsax.lamp,
            label: 'New idea',
            onTap: () => context.push('/guided-input'),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: _QuickActionButton(
            icon: Iconsax.document_text,
            label: 'Templates',
            onTap: () => context.go('/explore'),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: _QuickActionButton(
            icon: Iconsax.bookmark,
            label: 'Saved',
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

/// A standardized, modern-looking action button with hover and tap effects.
class _QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  _QuickActionButtonState createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<_QuickActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFFFFF), Color(0xFFF7F7FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFFEBEBFF)),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? const Color(0x339A9AFF)
                    : const Color(0x229A9AFF),
                blurRadius: _isHovered ? 16 : 8,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildIcon(),
              const SizedBox(height: 12.0),
              _buildLabel(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the icon container with a consistent, modern style.
  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Icon(widget.icon, color: Colors.white, size: 20),
    );
  }

  /// Builds the text label with a consistent style.
  Widget _buildLabel() {
    return Text(
      widget.label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF374151),
      ),
    );
  }
}
