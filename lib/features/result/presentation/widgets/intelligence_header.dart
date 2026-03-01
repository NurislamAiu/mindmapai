import 'package:flutter/material.dart';
import '../../domain/entities/startup_analysis.dart';

class IntelligenceHeader extends StatefulWidget {
  final StartupAnalysis data;

  const IntelligenceHeader({super.key, required this.data});

  @override
  State<IntelligenceHeader> createState() => _IntelligenceHeaderState();
}

class _IntelligenceHeaderState extends State<IntelligenceHeader> {
  bool _isExpanded = false;

  Color _getScoreColor(int score) {
    if (score >= 9) return const Color(0xFF10B981);
    if (score >= 7) return const Color(0xFF6366F1);
    if (score >= 4) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  Color _getRiskBgColor(String risk) {
    if (risk == 'Low') return const Color(0xFFD1FAE5);
    if (risk == 'Medium') return const Color(0xFFFEF3C7);
    return const Color(0xFFFEE2E2);
  }

  Color _getRiskTextColor(String risk) {
    if (risk == 'Low') return const Color(0xFF047857);
    if (risk == 'Medium') return const Color(0xFFB45309);
    return const Color(0xFFB91C1C);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE9EBEF))),
      ),
      child: AnimatedCrossFade(
        firstChild: _buildCollapsed(),
        secondChild: _buildExpanded(),
        crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildCollapsed() {
    return InkWell(
      onTap: () => setState(() => _isExpanded = true),
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
                    value: widget.data.readinessPercent / 100,
                    strokeWidth: 4,
                    backgroundColor: const Color(0xFFF1F2F4),
                    color: const Color(0xFF6366F1),
                  ),
                  Center(
                    child: Text(
                      '${widget.data.overallScore}',
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
                    'Risk: ${widget.data.riskLevel} • Weakest: ${widget.data.weakestArea}',
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
            const Icon(Icons.expand_more, color: Color(0xFF717182)),
          ],
        ),
      ),
    );
  }

  Widget _buildExpanded() {
    final data = widget.data;
    return InkWell(
      onTap: () => setState(() => _isExpanded = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: data.readinessPercent / 100,
                            strokeWidth: 8,
                            backgroundColor: const Color(0xFFF1F2F4),
                            color: const Color(0xFF6366F1),
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${data.overallScore}/10',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF030213),
                                    height: 1.0,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${data.readinessPercent}%',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF717182),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Startup Readiness',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF717182),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       const Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             'Weakest Area',
                             style: TextStyle(fontSize: 13, color: Color(0xFF717182)),
                           ),
                           Icon(Icons.expand_less, color: Color(0xFF717182)),
                         ],
                       ),
                       const SizedBox(height: 4),
                       Text(
                         data.weakestArea,
                         style: const TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.w600,
                           color: Color(0xFF030213),
                         ),
                       ),
                       const SizedBox(height: 12),
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                         decoration: BoxDecoration(
                           color: _getRiskBgColor(data.riskLevel),
                           borderRadius: BorderRadius.circular(20),
                           border: Border.all(color: _getRiskTextColor(data.riskLevel).withOpacity(0.2)),
                         ),
                         child: Text(
                           'Risk: ${data.riskLevel}',
                           style: TextStyle(
                             fontSize: 12,
                             fontWeight: FontWeight.w500,
                             color: _getRiskTextColor(data.riskLevel),
                           ),
                         ),
                       ),
                     ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: data.branches.map((branch) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE9EBEF)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      branch.title,
                      style: const TextStyle(fontSize: 13, color: Color(0xFF717182)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${branch.score}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _getScoreColor(branch.score),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
