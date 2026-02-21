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
    final baseColor = Colors.deepPurple;
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // TODO: Navigate to analyze screen
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.0),
            gradient: LinearGradient(
              colors: [baseColor.shade400, baseColor.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? baseColor.shade200.withOpacity(0.6)
                    : baseColor.shade200.withOpacity(0.4),
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
                        -300 + (_shineController.value * 800),
                        -100,
                      ),
                      child: Transform.rotate(
                        angle: -math.pi / 4,
                        child: Container(
                          width: 150,
                          height: 400,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.0),
                                Colors.white.withOpacity(0.15),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: const Icon(Iconsax.magic_star, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Analyze a new idea',
                              style: textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Transform your thoughts into clarity',
                              style: textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.9)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),

                  // Bullet points section
                  _buildBulletPoint(textTheme, 'AI analysis', 'Visual mind map'),
                  const SizedBox(height: 10),
                  _buildBulletPoint(textTheme, 'Clear next steps'),

                  const SizedBox(height: 24.0),

                  // Footer section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.clock, color: Colors.white70, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Takes ~30 seconds',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                      const Icon(Iconsax.arrow_right_3, color: Colors.white),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(TextTheme textTheme, String text1, [String? text2]) {
    return Row(
      children: [
        const Text('•', style: TextStyle(color: Colors.white70, fontSize: 18)),
        const SizedBox(width: 12),
        Text(text1, style: textTheme.bodyMedium?.copyWith(color: Colors.white, letterSpacing: 0.5)),
        if (text2 != null) ...[
          const SizedBox(width: 16),
          const Text('•', style: TextStyle(color: Colors.white70, fontSize: 18)),
          const SizedBox(width: 12),
          Text(text2, style: textTheme.bodyMedium?.copyWith(color: Colors.white, letterSpacing: 0.5)),
        ]
      ],
    );
  }
}
