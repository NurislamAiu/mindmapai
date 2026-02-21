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
      gradient: const LinearGradient(
        colors: [Color(0xFFF5F3FF), Color(0xFFEDE9FE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: const Color(0x99D1C4E9)),
      boxShadow: [
        BoxShadow(
          color: _isHovered ? const Color(0x227C3AED) : const Color(0x117C3AED),
          blurRadius: _isHovered ? 20 : 10,
          offset: Offset(0, _isHovered ? 6 : 4),
        )
      ],
    );
  }

  // --- Content Builders ---

  Widget _buildContinueContent(ContinueFocusData data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTopAccentBar(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              const _CardIcon(icon: Iconsax.lamp),
              const SizedBox(width: 16),
              _buildContinueInfoColumn(data),
              const SizedBox(width: 12),
              Icon(Iconsax.arrow_right_3, color: Colors.grey[500]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedContent(RecommendedFocusData data) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const _CardIcon(icon: Iconsax.magic_star),
          const SizedBox(width: 16),
          _buildRecommendedInfoColumn(data),
        ],
      ),
    );
  }

  // --- Sub-component Builders ---

  Widget _buildTopAccentBar() {
    return Container(
      height: 2.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
      ),
    );
  }

  Widget _buildContinueInfoColumn(ContinueFocusData data) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Continue where you left off',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${data.ideaTitle} • Started ${data.timeSince}',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          _AnimatedProgressBar(animation: _progressController),
        ],
      ),
    );
  }

  Widget _buildRecommendedInfoColumn(RecommendedFocusData data) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.4),
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
        backgroundColor: Colors.white.withOpacity(0.7),
        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
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
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFEDE9FE)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Icon(icon, color: const Color(0xFF7C3AED), size: 20),
    );
  }
}
