import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomePrimaryActionCard extends StatefulWidget {
  const HomePrimaryActionCard({super.key});

  @override
  State<HomePrimaryActionCard> createState() => _HomePrimaryActionCardState();
}

class _HomePrimaryActionCardState extends State<HomePrimaryActionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shineController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // TODO: Navigate to analyze screen
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            gradient: const LinearGradient(
              colors: [Color(0xFF5B21B6), Color(0xFF4C1D95)], // Darker violet
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? const Color(0xFF5B21B6).withOpacity(0.6)
                    : const Color(0xFF5B21B6).withOpacity(0.4),
                blurRadius: _isHovered ? 20 : 12,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Stack(
            children: [
              // The animated shine effect
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
              // The content of the card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Row(
                  children: [
                    _buildIcon(),
                    const SizedBox(width: 16),
                    _buildTextContent(),
                    const Icon(Iconsax.arrow_right_3, color: Colors.white70),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the leading icon with a glassmorphism effect.
  Widget _buildIcon() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: const Icon(Iconsax.magic_star, color: Colors.white, size: 24),
    );
  }

  /// Builds the text content with high-contrast white text.
  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Analyze a new idea',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Transform your thoughts into clarity',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
