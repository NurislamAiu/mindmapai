import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/startup_analysis.dart';
import '../cubit/result_cubit.dart';

class ResultMapView extends StatefulWidget {
  final StartupAnalysis data;

  const ResultMapView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ResultMapView> createState() => _ResultMapViewState();
}

class _ResultMapViewState extends State<ResultMapView> {
  late TransformationController _transformationController;
  final Set<String> _expandedNodes = {};

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    
    _transformationController.value = Matrix4.identity()
      ..translate(-40.0, 50.0)
      ..scale(0.35);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _toggleNode(String id) {
    setState(() {
      if (_expandedNodes.contains(id)) {
        _expandedNodes.remove(id);
      } else {
        _expandedNodes.clear();
        _expandedNodes.add(id);
      }
    });
  }

  Color _getScoreColor(int score) {
    if (score >= 9) return const Color(0xFF10B981);
    if (score >= 7) return const Color(0xFF6366F1);
    if (score >= 4) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAFAFA),
      child: InteractiveViewer(
        transformationController: _transformationController,
        boundaryMargin: const EdgeInsets.all(1200),
        minScale: 0.1,
        maxScale: 4.0,
        constrained: false,
        panEnabled: true,
        scaleEnabled: true,
        clipBehavior: Clip.none,
        child: SizedBox(
          width: 1400,
          height: 900,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _GridPainter(),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(
                  painter: _ConnectionsPainter(data: widget.data),
                ),
              ),
              ..._buildSubBranchesLayers(context),
              Positioned(
                left: 550,
                top: 380,
                width: 300,
                height: 140,
                child: _buildCenterNode(),
              ),
              ..._buildBranchNodes(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterNode() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.data.ideaTitle.split(' for ').first,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          if (widget.data.ideaTitle.contains(' for '))
            Text(
              'for ${widget.data.ideaTitle.split(' for ').last}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Overall: ${widget.data.overallScore}/10',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSubBranchesLayers(BuildContext context) {
    final positions = [
      const Offset(150, 130),
      const Offset(150, 330),
      const Offset(150, 530),
      const Offset(950, 130),
      const Offset(950, 330),
      const Offset(950, 530),
    ];

    List<Widget> layers = [];
    for (int i = 0; i < widget.data.branches.length && i < positions.length; i++) {
      final branch = widget.data.branches[i];
      final isExpanded = _expandedNodes.contains(branch.id);

      layers.add(
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !isExpanded,
            child: _SubBranchesLayer(
              branch: branch,
              parentPos: positions[i],
              isExpanded: isExpanded,
              color: _getScoreColor(branch.score),
            ),
          ),
        ),
      );
    }
    return layers;
  }

  List<Widget> _buildBranchNodes(BuildContext context) {
    final positions = [
      const Offset(150, 130),
      const Offset(150, 330),
      const Offset(150, 530),
      const Offset(950, 130),
      const Offset(950, 330),
      const Offset(950, 530),
    ];

    List<Widget> nodes = [];
    for (int i = 0; i < widget.data.branches.length && i < positions.length; i++) {
      final branch = widget.data.branches[i];
      final pos = positions[i];
      final color = _getScoreColor(branch.score);
      final isExpanded = _expandedNodes.contains(branch.id);

      nodes.add(
        Positioned(
          left: pos.dx,
          top: pos.dy,
          width: 250,
          child: GestureDetector(
            // NEW: Single tap to expand/collapse
            onTap: () => _toggleNode(branch.id),
            // NEW: Long press to show details
            onLongPress: () {
              context.read<ResultCubit>().selectBranch(branch);
            },
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE9EBEF), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                branch.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF030213),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedRotation(
                              turns: isExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.expand_more,
                                size: 20,
                                color: color.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F2F4),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: branch.score / 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (branch.bullets.isNotEmpty)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6366F1),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      branch.bullets[0],
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF717182),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 6),
                            if (branch.bullets.length > 1)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6366F1),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      branch.bullets[1],
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF717182),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -12,
                    top: -12,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${branch.score}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return nodes;
  }
}

class _SubBranchesLayer extends StatelessWidget {
  final StartupBranch branch;
  final Offset parentPos;
  final bool isExpanded;
  final Color color;

  const _SubBranchesLayer({
    Key? key,
    required this.branch,
    required this.parentPos,
    required this.isExpanded,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parentCenter = Offset(parentPos.dx + 125, parentPos.dy + 70);
    final isLeft = parentPos.dx < 700;
    final N = branch.bullets.length;
    final spacing = 65.0;
    final startY = parentCenter.dy - ((N - 1) * spacing) / 2;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: isExpanded ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        if (value == 0.0) return const SizedBox.shrink();

        List<Widget> subNodes = [];
        List<Offset> lineTargets = [];

        for (int i = 0; i < N; i++) {
          final targetX = isLeft ? parentPos.dx - 240 : parentPos.dx + 290;
          final targetY = startY + (i * spacing);

          final anchorX = isLeft ? targetX + 200 : targetX;
          final anchorY = targetY + 25;
          lineTargets.add(Offset(anchorX, anchorY));

          final currentX = lerpDouble(parentCenter.dx, targetX, value)!;
          final currentY = lerpDouble(parentCenter.dy, targetY, value)!;

          subNodes.add(
            Positioned(
              left: currentX,
              top: currentY,
              child: Transform.scale(
                scale: 0.5 + 0.5 * value,
                child: Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: color.withOpacity(0.4), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      branch.bullets[i],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF030213),
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _SubLinesPainter(
                  parentCenter: parentCenter,
                  subNodesAnchors: lineTargets,
                  progress: value,
                  color: color,
                ),
              ),
            ),
            ...subNodes,
          ],
        );
      },
    );
  }
}

class _SubLinesPainter extends CustomPainter {
  final Offset parentCenter;
  final List<Offset> subNodesAnchors;
  final double progress;
  final Color color;

  _SubLinesPainter({
    required this.parentCenter,
    required this.subNodesAnchors,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity((0.4 * progress).clamp(0.0, 1.0))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (var target in subNodesAnchors) {
      final currentAnchor = Offset(
        lerpDouble(parentCenter.dx, target.dx, progress)!,
        lerpDouble(parentCenter.dy, target.dy, progress)!,
      );

      final path = Path();
      path.moveTo(parentCenter.dx, parentCenter.dy);
      
      final controlX = (parentCenter.dx + currentAnchor.dx) / 2;
      path.cubicTo(
        controlX, parentCenter.dy,
        controlX, currentAnchor.dy,
        currentAnchor.dx, currentAnchor.dy,
      );

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SubLinesPainter oldDelegate) => true;
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(0.05)
      ..style = PaintingStyle.fill;
    
    for (double i = 0; i < size.width; i += 40) {
      for (double j = 0; j < size.height; j += 40) {
        canvas.drawCircle(Offset(i, j), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ConnectionsPainter extends CustomPainter {
  final StartupAnalysis data;

  _ConnectionsPainter({required this.data});

  Color _getScoreColor(int score) {
    if (score >= 7) return const Color(0xFF6366F1);
    if (score >= 4) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = const Offset(700, 450);
    final targets = [
      const Offset(300, 200),
      const Offset(300, 400),
      const Offset(300, 600),
      const Offset(1100, 200),
      const Offset(1100, 400),
      const Offset(1100, 600),
    ];

    for (int i = 0; i < targets.length && i < data.branches.length; i++) {
      final paint = Paint()
        ..color = _getScoreColor(data.branches[i].score).withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;

      final path = Path();
      path.moveTo(center.dx, center.dy);
      path.quadraticBezierTo(
        (center.dx + targets[i].dx) / 2,
        center.dy,
        targets[i].dx,
        targets[i].dy,
      );
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
