import 'package:flutter/material.dart';
import 'dart:math' as math;

class PrimaryActionCard extends StatefulWidget {
  const PrimaryActionCard({super.key});

  @override
  State<PrimaryActionCard> createState() => _PrimaryActionCardState();
}

class _PrimaryActionCardState extends State<PrimaryActionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shineController;

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
    final baseColor = Colors.deepPurple; // A more vibrant purple
    final textTheme = Theme.of(context).textTheme;

    return Container(
      clipBehavior: Clip.antiAlias, // Important for the shine effect
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        gradient: LinearGradient(
          colors: [baseColor.shade400, baseColor.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: baseColor.shade200.withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
                    child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 12),
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
                          style: textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.9)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              
              // Bullet points section
              _buildBulletPoint(textTheme, 'AI analysis', 'Visual mind map'),
              const SizedBox(height: 8),
              _buildBulletPoint(textTheme, 'Clear next steps'),

              const SizedBox(height: 20.0),

              // Footer section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded, color: Colors.white70, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'Takes ~30 seconds',
                        style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(TextTheme textTheme, String text1, [String? text2]) {
    return Row(
      children: [
        const Text('•', style: TextStyle(color: Colors.white70, fontSize: 18)),
        const SizedBox(width: 8),
        Text(text1, style: textTheme.bodyMedium?.copyWith(color: Colors.white, letterSpacing: 0.5)),
        if (text2 != null) ...[
          const SizedBox(width: 8),
          const Text('•', style: TextStyle(color: Colors.white70, fontSize: 18)),
          const SizedBox(width: 8),
          Text(text2, style: textTheme.bodyMedium?.copyWith(color: Colors.white, letterSpacing: 0.5)),
        ]
      ],
    );
  }
}
