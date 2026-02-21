import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// Enum to represent different risk levels.
enum RiskLevel { Low, Medium, High }

/// Data model for the status card.
class StatusInfo {
  final String title;
  final int percentage;
  final RiskLevel risk;

  const StatusInfo({
    required this.title,
    required this.percentage,
    required this.risk,
  });
}

/// A card widget to display a status, like "Startup Readiness".
///
/// It's designed to be reusable and is driven by the [StatusInfo] data model.
class HomeStatusCard extends StatelessWidget {
  final StatusInfo status;

  const HomeStatusCard({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0x4DEDE9FE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0x99D1C4E9)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(99, 102, 241, 0.08),
            offset: Offset(0, 8),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTopAccentBar(),
          _buildCardContent(),
        ],
      ),
    );
  }

  /// Builds the decorative gradient bar at the top of the card.
  Widget _buildTopAccentBar() {
    return Container(
      height: 2.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFF6366F1)],
        ),
      ),
    );
  }

  /// Builds the main content area of the card.
  Widget _buildCardContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 16),
          Expanded(child: _buildInfoText()),
        ],
      ),
    );
  }

  /// Builds the leading icon with a gradient background.
  Widget _buildIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: const Icon(Iconsax.magic_star, color: Colors.white, size: 20),
    );
  }

  /// Builds the text content (title and risk pill).
  Widget _buildInfoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${status.title}: ${status.percentage}%',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 4),
        _RiskPill(risk: status.risk),
      ],
    );
  }
}

/// A small pill-shaped widget to display the risk level.
class _RiskPill extends StatelessWidget {
  final RiskLevel risk;

  const _RiskPill({required this.risk});

  String get _riskText {
    switch (risk) {
      case RiskLevel.Low:
        return 'Risk: Low';
      case RiskLevel.Medium:
        return 'Risk: Medium';
      case RiskLevel.High:
        return 'Risk: High';
    }
  }

  Color get _backgroundColor {
    switch (risk) {
      case RiskLevel.Low:
        return const Color(0xFFD1FAE5); // Green
      case RiskLevel.Medium:
        return const Color(0xFFFEF3C7); // Amber
      case RiskLevel.High:
        return const Color(0xFFFEE2E2); // Red
    }
  }

  Color get _borderColor {
    switch (risk) {
      case RiskLevel.Low:
        return const Color(0xFFA7F3D0);
      case RiskLevel.Medium:
        return const Color(0xFFFDE68A);
      case RiskLevel.High:
        return const Color(0xFFFECACA);
    }
  }

  Color get _textColor {
    switch (risk) {
      case RiskLevel.Low:
        return const Color(0xFF065F46);
      case RiskLevel.Medium:
        return const Color(0xFF92400E);
      case RiskLevel.High:
        return const Color(0xFF991B1B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Text(
        _riskText,
        style: TextStyle(
          color: _textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
