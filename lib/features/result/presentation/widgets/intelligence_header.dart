import 'package:flutter/material.dart';
import '../../domain/entities/startup_analysis.dart';

class IntelligenceHeader extends StatelessWidget {
  final StartupAnalysis data;

  const IntelligenceHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE9EBEF))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: data.readinessPercent / 100,
                    strokeWidth: 4,
                    backgroundColor: const Color(0xFFF1F2F4),
                    color: const Color(0xFF6366F1),
                  ),
                  Center(
                    child: Text(
                      '${data.overallScore}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF030213),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Startup Readiness',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF030213),
                    ),
                  ),
                  Text(
                    'Risk: ${data.riskLevel} • Weakest: ${data.weakestArea}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF717182),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
