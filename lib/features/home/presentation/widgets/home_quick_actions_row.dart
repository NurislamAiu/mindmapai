import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
            onTap: () {},
            gradient: const LinearGradient(
              colors: [Color(0xFFEDE9FE), Color(0xCCEDE9FE), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            iconGradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF7C3AED)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderColor: const Color(0xADD1C4E9),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: _QuickActionButton(
            icon: Iconsax.document_text,
            label: 'Templates',
            onTap: () {},
            gradient: const LinearGradient(
              colors: [Color(0xFFF5F3FF), Color(0xCCF5F3FF), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            iconGradient: const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderColor: const Color(0xADD8B4FE),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: _QuickActionButton(
            icon: Iconsax.bookmark,
            label: 'Saved',
            onTap: () {},
            gradient: const LinearGradient(
              colors: [Color(0xFFFEF9C3), Color(0xCCFEF9C3), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            iconGradient: const LinearGradient(
              colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderColor: const Color(0xADFDE68A),
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Gradient gradient;
  final Gradient iconGradient;
  final Color borderColor;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.gradient,
    required this.iconGradient,
    required this.borderColor,
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
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: widget.borderColor),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.borderColor.withOpacity(0.5)
                    : Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: _isHovered ? 12 : 8,
                offset: Offset(0, _isHovered ? 6 : 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  gradient: widget.iconGradient,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Icon(widget.icon, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 12.0),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
