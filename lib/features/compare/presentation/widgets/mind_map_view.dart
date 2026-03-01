import 'package:flutter/material.dart';
import 'package:mindmapai/features/compare/domain/entities/mind_map_node_entity.dart';
import 'package:mindmapai/features/compare/domain/entities/mind_map_version_entity.dart';

class MindMapView extends StatelessWidget {
  final MindMapVersionEntity version;
  final bool isCurrentVersion;

  const MindMapView({super.key, required this.version, required this.isCurrentVersion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9EBEF)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CustomPaint(
          painter: _MindMapPainter(version: version, isCurrent: isCurrentVersion),
        ),
      ),
    );
  }
}

class _MindMapPainter extends CustomPainter {
  final MindMapVersionEntity version;
  final bool isCurrent;
  
  _MindMapPainter({required this.version, required this.isCurrent});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFD1D5DB)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final rootNode = version.nodes.firstWhere((n) => n.type == NodeType.root, orElse: () => version.nodes.first);
    
    // Draw lines
    for (final node in version.nodes) {
      if (node.type == NodeType.leaf) {
        final parent = _findParentFor(node, version.nodes);
        if (parent != null) {
          canvas.drawLine(parent.position, node.position, linePaint);
        }
      } else if (node.type == NodeType.branch) {
        canvas.drawLine(rootNode.position, node.position, linePaint);
      }
    }

    // Draw nodes
    for (final node in version.nodes) {
      _drawNode(canvas, node, size);
    }
  }

  void _drawNode(Canvas canvas, MindMapNodeEntity node, Size size) {
    final nodeSize = _getNodeSize(node.type);
    final rect = Rect.fromCenter(center: node.position, width: nodeSize.width, height: nodeSize.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(node.type == NodeType.root ? 14 : 10));

    final paint = _getNodePaint(node, isCurrent);
    canvas.drawRRect(rrect, paint['fill']!);
    canvas.drawRRect(rrect, paint['stroke']!);
    
    _drawNodeText(canvas, node.label, node.position, node.type);
  }

  void _drawNodeText(Canvas canvas, String text, Offset position, NodeType type) {
    final textStyle = TextStyle(
      color: type == NodeType.root ? Colors.white : const Color(0xFF030213),
      fontSize: type == NodeType.root ? 14 : (type == NodeType.branch ? 13 : 12),
      fontWeight: type == NodeType.root ? FontWeight.w600 : (type == NodeType.branch ? FontWeight.w500 : FontWeight.w400),
    );
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: _getNodeSize(type).width - 16);
    final offset = Offset(position.dx - textPainter.width / 2, position.dy - textPainter.height / 2);
    textPainter.paint(canvas, offset);
  }

  MindMapNodeEntity? _findParentFor(MindMapNodeEntity leaf, List<MindMapNodeEntity> allNodes) {
    MindMapNodeEntity? parent;
    double minDistance = double.infinity;
    for(final node in allNodes) {
      if(node.type == NodeType.branch) {
        final distance = (leaf.position - node.position).distance;
        if(distance < minDistance) {
          minDistance = distance;
          parent = node;
        }
      }
    }
    return parent;
  }

  Size _getNodeSize(NodeType type) {
    if (type == NodeType.root) return const Size(180, 56);
    if (type == NodeType.branch) return const Size(140, 44);
    return const Size(120, 36); // Leaf
  }

  Map<String, Paint> _getNodePaint(MindMapNodeEntity node, bool isCurrentVersion) {
    Color fillColor = Colors.white;
    Color strokeColor = const Color(0xFFE9EBEF);
    double strokeWidth = 1.5;

    final status = isCurrentVersion ? node.status : NodeStatus.unchanged;

    if (node.type == NodeType.root) {
      fillColor = const Color(0xFF6366F1);
      strokeColor = Colors.transparent;
    } else if (status == NodeStatus.added) {
      fillColor = const Color(0xFFECFDF5);
      strokeColor = const Color(0xFF6EE7B7);
      strokeWidth = 2;
    } else if (status == NodeStatus.modified) {
      fillColor = const Color(0xFFFEF3C7);
      strokeColor = const Color(0xFFFBBF24);
      strokeWidth = 2;
    } else if (node.type == NodeType.leaf) {
      fillColor = const Color(0xFFF8F9FA);
    }

    return {
      'fill': Paint()..color = fillColor,
      'stroke': Paint()
        ..color = strokeColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke,
    };
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
