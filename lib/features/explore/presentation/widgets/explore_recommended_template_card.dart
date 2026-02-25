import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:go_router/go_router.dart';
import '../../domain/entities/explore_template.dart';
import 'explore_template_card_widgets.dart';

class RecommendedTemplateCard extends StatefulWidget {
  final Template template;
  const RecommendedTemplateCard({super.key, required this.template});

  @override
  State<RecommendedTemplateCard> createState() => _RecommendedTemplateCardState();
}

class _RecommendedTemplateCardState extends State<RecommendedTemplateCard>
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
    final textTheme = Theme.of(context).textTheme;
    final baseColor = getTemplateColor(widget.template.color);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: [
              Icon(Icons.star_rounded, color: baseColor.shade400, size: 20),
              const SizedBox(width: 8),
              Text(
                'Recommended for you',
                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // The main card container
        Container(
          clipBehavior: Clip.antiAlias, // Important for the shine effect
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.0),
            gradient: LinearGradient(
              colors: [baseColor.shade800, baseColor.shade900],
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
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.push('/guided-input', extra: widget.template),
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Using a custom header for white text
                        _buildHeader(context, widget.template),
                        const SizedBox(height: 16),
                        TemplateBadges(template: widget.template, isRecommended: true),
                        const SizedBox(height: 16),
                        Text(
                          widget.template.outcome,
                          style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                        ),
                        const SizedBox(height: 12),
                        if (widget.template.reason != null)
                          Text(
                            '"${widget.template.reason!}"',
                            style: textTheme.bodyMedium?.copyWith(
                              color: baseColor.shade200,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  // A custom header widget to handle white text color
  Widget _buildHeader(BuildContext context, Template template) {
    final textTheme = Theme.of(context).textTheme;
    final color = getTemplateColor(template.color);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(template.icon, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                template.title,
                style: textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                template.description,
                style: textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
