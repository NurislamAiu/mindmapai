import 'package:flutter/material.dart';
import 'package:mindmapai/features/compare/domain/entities/mind_map_node_entity.dart';
import 'package:mindmapai/features/compare/domain/entities/mind_map_version_entity.dart';
import 'dart:math';
import 'dart:ui';

// Main Widget - StatefulWidget for interactivity
class MindMapView extends StatefulWidget {
  final MindMapVersionEntity version;
  final bool isCurrentVersion;

  const MindMapView({super.key, required this.version, required this.isCurrentVersion});

  @override
  State<MindMapView> createState() => _MindMapViewState();
}

class _MindMapViewState extends State<MindMapView> {
  String? highlightedNodeId;
  bool _isBlurred = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9EBEF)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Container(
              color: const Color(0xFFF8F9FA),
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final laidOutNodes = _calculateBalancedLayout(widget.version.nodes, constraints.biggest);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: _isBlurred ? 4 : 0, sigmaY: _isBlurred ? 4 : 0),
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: Size.infinite,
                                painter: _MindMapConnectionPainter(
                                  originalNodes: widget.version.nodes,
                                  laidOutNodes: laidOutNodes,
                                  highlightedNodeId: highlightedNodeId,
                                ),
                              ),
                              ...laidOutNodes.map((node) {
                                final nodeSize = _getNodeSize(node.type);
                                return Positioned(
                                  left: node.position.dx - nodeSize.width / 2,
                                  top: node.position.dy - nodeSize.height / 2,
                                  width: nodeSize.width,
                                  height: nodeSize.height,
                                  child: GestureDetector(
                                    onTap: () {
                                      if(!_isBlurred) {
                                        setState(() {
                                          highlightedNodeId = highlightedNodeId == node.id ? null : node.id;
                                        });
                                      }
                                    },
                                    child: _MindMapNode(
                                      node: node,
                                      isCurrent: widget.isCurrentVersion,
                                      isHighlighted: highlightedNodeId == node.id,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        if (_isBlurred)
                          Center(
                            child: FilledButton(
                              onPressed: () => setState(() {
                                _isBlurred = false;
                              }),
                              child: const Text('Посмотреть'),
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF4F46E5),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontFamily: 'Manrope', fontSize: 14, color: Color(0xFF030213)),
              children: [
                TextSpan(text: '${widget.version.label} ', style: const TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(
                  text: '${widget.version.nodes.length} nodes',
                  style: const TextStyle(color: Color(0xFF717182), fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Size _getNodeSize(NodeType type) {
    if (type == NodeType.root) return const Size(60, 22);
    if (type == NodeType.branch) return const Size(50, 20);
    return const Size(45, 18);
  }

  List<MindMapNodeEntity> _calculateBalancedLayout(List<MindMapNodeEntity> nodes, Size viewSize) {
    if (nodes.isEmpty) return [];

    final laidOutNodes = <MindMapNodeEntity>[];
    final root = nodes.firstWhere((n) => n.type == NodeType.root);
    final branches = nodes.where((n) => n.type == NodeType.branch).toList().take(6).toList();
    
    final center = Offset(viewSize.width / 2, viewSize.height / 2);
    laidOutNodes.add(root.copyWith(position: center));

    final midPoint = 3; 
    final leftBranches = branches.length >= midPoint ? branches.sublist(0, midPoint) : branches;
    final rightBranches = branches.length > midPoint ? branches.sublist(midPoint) : <MindMapNodeEntity>[];

    final leftHeight = _calculateSideHeight(nodes, leftBranches);
    final rightHeight = _calculateSideHeight(nodes, rightBranches);
    final maxHeight = max(leftHeight, rightHeight);

    _layoutSide(nodes, leftBranches, laidOutNodes, center, leftHeight, maxHeight, viewSize, isLeft: true);
    _layoutSide(nodes, rightBranches, laidOutNodes, center, rightHeight, maxHeight, viewSize, isLeft: false);

    return laidOutNodes;
  }

  double _calculateSideHeight(List<MindMapNodeEntity> allNodes, List<MindMapNodeEntity> branches) {
    double height = 0;
    const vPadding = 12.0;
    for (var branch in branches) {
      final leaves = allNodes.where((n) => n.type == NodeType.leaf && _findParentFor(n, allNodes)?.id == branch.id).toList();
      final branchSize = _getNodeSize(NodeType.branch);
      final leavesHeight = leaves.isEmpty ? 0 : (leaves.length * _getNodeSize(NodeType.leaf).height) + (leaves.length - 1) * (vPadding / 2);
      height += max(branchSize.height, leavesHeight) + vPadding;
    }
    return height;
  }
  
  void _layoutSide(List<MindMapNodeEntity> allNodes, List<MindMapNodeEntity> branches, List<MindMapNodeEntity> laidOutNodes, Offset center, double sideHeight, double maxHeight, Size viewSize, {required bool isLeft}) {
    const vPadding = 12.0;
    const hPaddingBranch = 65.0;
    const hPaddingLeaf = 45.0;

    double currentY = center.dy - maxHeight / 2 + (maxHeight - sideHeight) / 2;

    for (var branch in branches) {
      final leaves = allNodes.where((n) => n.type == NodeType.leaf && _findParentFor(n, allNodes)?.id == branch.id).toList();
      final branchSize = _getNodeSize(NodeType.branch);
      
      final leavesHeight = leaves.isEmpty ? 0 : (leaves.length * _getNodeSize(NodeType.leaf).height) + (leaves.length - 1) * (vPadding / 2);
      final groupHeight = max(branchSize.height, leavesHeight);

      final branchX = isLeft ? center.dx - hPaddingBranch : center.dx + hPaddingBranch;
      final branchY = currentY + groupHeight / 2;
      laidOutNodes.add(branch.copyWith(position: Offset(branchX, branchY)));
      
      double leafStartY = currentY + (groupHeight - leavesHeight) / 2;
      for(int i=0; i<leaves.length; i++) {
        final leaf = leaves[i];
        final leafSize = _getNodeSize(NodeType.leaf);
        final leafX = isLeft ? branchX - hPaddingLeaf : branchX + hPaddingLeaf;
        final leafY = leafStartY + i * (leafSize.height + vPadding / 2) + leafSize.height / 2;
        laidOutNodes.add(leaf.copyWith(position: Offset(leafX, leafY)));
      }

      currentY += groupHeight + vPadding;
    }
  }

  MindMapNodeEntity? _findParentFor(MindMapNodeEntity child, List<MindMapNodeEntity> allNodes) {
    final parentType = child.type == NodeType.leaf ? NodeType.branch : NodeType.root;
    MindMapNodeEntity? closestParent;
    double minDistance = double.infinity;
    for (final node in allNodes) {
      if (node.type == parentType) {
        final distance = (child.position - node.position).distance;
        if (distance < minDistance) {
          minDistance = distance;
          closestParent = node;
        }
      }
    }
    return closestParent;
  }
}

// Node Widget
class _MindMapNode extends StatelessWidget {
  final MindMapNodeEntity node;
  final bool isCurrent;
  final bool isHighlighted;
  const _MindMapNode({required this.node, required this.isCurrent, required this.isHighlighted});

  @override
  Widget build(BuildContext context) {
    final colors = _getNodeColors(node, isCurrent);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: colors['fill'],
        border: Border.all(color: isHighlighted ? const Color(0xFF4F46E5) : colors['stroke']!, width: isHighlighted ? 1.5 : 1),
        borderRadius: BorderRadius.circular(4),
        boxShadow: isHighlighted ? [BoxShadow(color: const Color(0xFF4F46E5).withOpacity(0.3), blurRadius: 5, spreadRadius: 1)] : [],
      ),
      child: Center(
        child: Text(node.label, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: colors['text'], fontSize: 5, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Map<String, Color> _getNodeColors(MindMapNodeEntity node, bool isCurrentVersion) {
    final status = isCurrentVersion ? node.status : NodeStatus.unchanged;
    if (node.type == NodeType.root) return {'fill': const Color(0xFF4F46E5), 'stroke': const Color(0xFF4338CA), 'text': Colors.white};
    if (status == NodeStatus.added) return {'fill': const Color(0xFFECFDF5), 'stroke': const Color(0xFFA7F3D0), 'text': const Color(0xFF047857)};
    if (status == NodeStatus.modified) return {'fill': const Color(0xFFFFFBEB), 'stroke': const Color(0xFFFDE68A), 'text': const Color(0xFFB45309)};
    return {'fill': Colors.white, 'stroke': const Color(0xFFE9EBEF), 'text': const Color(0xFF374151)};
  }
}

// Connection Lines Painter with CURVED lines
class _MindMapConnectionPainter extends CustomPainter {
  final List<MindMapNodeEntity> originalNodes;
  final List<MindMapNodeEntity> laidOutNodes;
  final String? highlightedNodeId;
  _MindMapConnectionPainter({required this.originalNodes, required this.laidOutNodes, this.highlightedNodeId});

  @override
  void paint(Canvas canvas, Size size) {
    final defaultPaint = Paint()..color = const Color(0xFFE5E7EB)..strokeWidth = 1.0..style = PaintingStyle.stroke;
    final highlightPaint = Paint()..color = const Color(0xFF4F46E5)..strokeWidth = 1.5..style = PaintingStyle.stroke;
    if (laidOutNodes.isEmpty) return;
    
    final nodeMap = {for (var node in laidOutNodes) node.id: node};

    for (final laidOutNode in laidOutNodes) {
      if (laidOutNode.type != NodeType.root) {
        final originalChild = originalNodes.firstWhere((n) => n.id == laidOutNode.id);
        final parentOriginal = _findParentFor(originalChild, originalNodes);
        if (parentOriginal != null && nodeMap.containsKey(parentOriginal.id)) {
          final startNode = nodeMap[parentOriginal.id]!;
          final endNode = laidOutNode;
          final isHighlighted = startNode.id == highlightedNodeId || endNode.id == highlightedNodeId;
          
          final path = Path();
          path.moveTo(startNode.position.dx, startNode.position.dy);
          path.cubicTo(
            startNode.position.dx + (endNode.position.dx - startNode.position.dx) * 0.5, startNode.position.dy,
            startNode.position.dx + (endNode.position.dx - startNode.position.dx) * 0.5, endNode.position.dy,
            endNode.position.dx, endNode.position.dy,
          );
          
          canvas.drawPath(path, isHighlighted ? highlightPaint : defaultPaint);
        }
      }
    }
  }

  MindMapNodeEntity? _findParentFor(MindMapNodeEntity child, List<MindMapNodeEntity> allNodes) {
    final parentType = child.type == NodeType.leaf ? NodeType.branch : NodeType.root;
    MindMapNodeEntity? closestParent;
    double minDistance = double.infinity;
    for (final node in allNodes) {
      if (node.type == parentType) {
        final distance = (child.position - node.position).distance;
        if (distance < minDistance) {
          minDistance = distance;
          closestParent = node;
        }
      }
    }
    return closestParent;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
