import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// --- Data Models (unchanged) ---

@immutable
sealed class FocusCardData {}

class ContinueFocusData extends FocusCardData {
  final String ideaTitle;
  final String timeSince;
  final double progress;

  ContinueFocusData({
    required this.ideaTitle,
    required this.timeSince,
    required this.progress,
  });
}

class RecommendedFocusData extends FocusCardData {
  final String title;
  final String subtitle;

  RecommendedFocusData({
    required this.title,
    required this.subtitle,
  });
}

// --- Main Widget ---

class HomeFocusCard extends StatefulWidget {
  final FocusCardData data;

  const HomeFocusCard({super.key, required this.data});

  @override
  State<HomeFocusCard> createState() => _HomeFocusCardState();
}

class _HomeFocusCardState extends State<HomeFocusCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    if (widget.data case ContinueFocusData d) {
      _progressController.animateTo(d.progress, curve: Curves.easeInOut);
    }
  }

  @override
  void didUpdateWidget(covariant HomeFocusCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data case ContinueFocusData d when oldWidget.data is! ContinueFocusData) {
      _progressController.animateTo(d.progress, curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        clipBehavior: Clip.antiAlias,
        decoration: _buildCardDecoration(),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () { /* TODO: Handle tap */ },
            borderRadius: BorderRadius.circular(19.0),
            child: switch (widget.data) {
              ContinueFocusData d => _buildContinueContent(d),
              RecommendedFocusData d => _buildRecommendedContent(d),
            },
          ),
        ),
      ),
    );
  }

  // --- Style & Decoration ---

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: const Color(0xFFE5E7EB)),
      boxShadow: [
        BoxShadow(
          color: _isHovered
              ? const Color(0xFF1F2937).withOpacity(0.08)
              : const Color(0xFF1F2937).withOpacity(0.05),
          blurRadius: _isHovered ? 15 : 10,
          offset: Offset(0, _isHovered ? 6 : 4),
        )
      ],
    );
  }

  // --- Content Builders ---

  Widget _buildContinueContent(ContinueFocusData data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Continue',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.ideaTitle,
            style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4F46E5),
                fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          _AnimatedProgressBar(animation: _progressController),
          const SizedBox(height: 8),
          Text(
            'Edited ${data.timeSince}',
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedContent(RecommendedFocusData data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardIcon(icon: Iconsax.magic_star),
          const SizedBox(height: 12),
          Text(
            data.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.subtitle,
            style: TextStyle(
                color: Colors.grey[600], fontSize: 14, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// --- Helper Widgets ---

class _AnimatedProgressBar extends AnimatedWidget {
  const _AnimatedProgressBar({required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: animation.value,
        minHeight: 6,
        backgroundColor: const Color(0xFFE5E7EB),
        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
      ),
    );
  }
}

class _CardIcon extends StatelessWidget {
  final IconData icon;

  const _CardIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Icon(icon, color: const Color(0xFF4F46E5), size: 20),
    );
  }
}
