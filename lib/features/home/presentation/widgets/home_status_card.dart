import 'package:flutter/material.dart';

enum RiskLevel { Low, Medium, High }

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

class HomeStatusCard extends StatelessWidget {
  final StatusInfo status;

  const HomeStatusCard({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${status.percentage}%',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F46E5),
            ),
          ),
          const SizedBox(height: 8),
          _RiskPill(risk: status.risk),
        ],
      ),
    );
  }
}

class _RiskPill extends StatelessWidget {
  final RiskLevel risk;

  const _RiskPill({required this.risk});

  String get _riskText {
    switch (risk) {
      case RiskLevel.Low:
        return 'Low Risk';
      case RiskLevel.Medium:
        return 'Medium Risk';
      case RiskLevel.High:
        return 'High Risk';
    }
  }

  Color get _backgroundColor {
    switch (risk) {
      case RiskLevel.Low:
        return const Color(0xFFECFDF5);
      case RiskLevel.Medium:
        return const Color(0xFFFFFBEB);
      case RiskLevel.High:
        return const Color(0xFFFEF2F2);
    }
  }

  Color get _textColor {
    switch (risk) {
      case RiskLevel.Low:
        return const Color(0xFF059669);
      case RiskLevel.Medium:
        return const Color(0xFFD97706);
      case RiskLevel.High:
        return const Color(0xFFDC2626);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
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
