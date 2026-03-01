import 'package:flutter/material.dart';
import '../../domain/entities/mind_map_node_entity.dart';
import '../../domain/entities/mind_map_version_entity.dart';

abstract class CompareLocalDataSource {
  Future<List<MindMapVersionEntity>> getVersions();
}

class CompareLocalDataSourceImpl implements CompareLocalDataSource {
  @override
  Future<List<MindMapVersionEntity>> getVersions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockVersions;
  }

  final _mockVersions = [
    MindMapVersionEntity(
      id: "v4",
      label: "Version 4",
      timestamp: "2 hours ago",
      nodes: [
        const MindMapNodeEntity(id: "root", label: "Meditation App", type: NodeType.root, position: Offset(250, 150)),
        const MindMapNodeEntity(id: "features", label: "Core Features", type: NodeType.branch, position: Offset(160, 75)),
        const MindMapNodeEntity(id: "feat1", label: "Guided Sessions", type: NodeType.leaf, position: Offset(90, 40)),
        const MindMapNodeEntity(id: "feat2", label: "Smart Reminders", type: NodeType.leaf, position: Offset(110, 100)),
        const MindMapNodeEntity(id: "feat3", label: "Progress Analytics", type: NodeType.leaf, position: Offset(100, 160)),
        const MindMapNodeEntity(id: "audience", label: "Target Audience", type: NodeType.branch, position: Offset(340, 60)),
        const MindMapNodeEntity(id: "aud1", label: "Tech Professionals", type: NodeType.leaf, position: Offset(410, 25)),
        const MindMapNodeEntity(id: "aud2", label: "Healthcare Workers", type: NodeType.leaf, position: Offset(400, 90)),
        const MindMapNodeEntity(id: "technical", label: "Technical Approach", type: NodeType.branch, position: Offset(360, 210)),
        const MindMapNodeEntity(id: "tech1", label: "Mobile First", type: NodeType.leaf, position: Offset(430, 190)),
        const MindMapNodeEntity(id: "tech2", label: "Offline Support", type: NodeType.leaf, position: Offset(420, 250)),
        const MindMapNodeEntity(id: "tech3", label: "Cloud Sync", type: NodeType.leaf, position: Offset(410, 310)),
        const MindMapNodeEntity(id: "business", label: "Business Model", type: NodeType.branch, position: Offset(170, 240)),
        const MindMapNodeEntity(id: "biz1", label: "Freemium Model", type: NodeType.leaf, position: Offset(100, 220)),
        const MindMapNodeEntity(id: "biz2", label: "Corporate Wellness", type: NodeType.leaf, position: Offset(110, 280)),
      ],
    ),
    MindMapVersionEntity(
      id: "v3",
      label: "Version 3",
      timestamp: "1 day ago",
      nodes: [
        const MindMapNodeEntity(id: "root", label: "Meditation App", type: NodeType.root, position: Offset(250, 150)),
        const MindMapNodeEntity(id: "features", label: "Features", type: NodeType.branch, position: Offset(160, 75)),
        const MindMapNodeEntity(id: "feat1", label: "Guided Sessions", type: NodeType.leaf, position: Offset(90, 40)),
        const MindMapNodeEntity(id: "feat2", label: "Smart Reminders", type: NodeType.leaf, position: Offset(110, 100)),
        const MindMapNodeEntity(id: "audience", label: "Target Audience", type: NodeType.branch, position: Offset(340, 60)),
        const MindMapNodeEntity(id: "aud1", label: "Tech Professionals", type: NodeType.leaf, position: Offset(410, 25)),
        const MindMapNodeEntity(id: "aud2", label: "Healthcare Workers", type: NodeType.leaf, position: Offset(400, 90)),
        const MindMapNodeEntity(id: "technical", label: "Tech Stack", type: NodeType.branch, position: Offset(360, 210)),
        const MindMapNodeEntity(id: "tech1", label: "Mobile First", type: NodeType.leaf, position: Offset(430, 190)),
        const MindMapNodeEntity(id: "tech2", label: "Offline Support", type: NodeType.leaf, position: Offset(420, 250)),
        const MindMapNodeEntity(id: "business", label: "Business Model", type: NodeType.branch, position: Offset(170, 240)),
        const MindMapNodeEntity(id: "biz1", label: "Freemium Model", type: NodeType.leaf, position: Offset(100, 220)),
        const MindMapNodeEntity(id: "biz2", label: "Corporate Wellness", type: NodeType.leaf, position: Offset(110, 280)),
      ],
    ),
    MindMapVersionEntity(
      id: "v2",
      label: "Version 2",
      timestamp: "3 days ago",
      nodes: [
        const MindMapNodeEntity(id: "root", label: "Meditation App", type: NodeType.root, position: Offset(250, 150)),
        const MindMapNodeEntity(id: "features", label: "Features", type: NodeType.branch, position: Offset(160, 75)),
        const MindMapNodeEntity(id: "feat1", label: "Guided Sessions", type: NodeType.leaf, position: Offset(90, 40)),
        const MindMapNodeEntity(id: "audience", label: "Audience", type: NodeType.branch, position: Offset(340, 60)),
        const MindMapNodeEntity(id: "aud1", label: "Professionals", type: NodeType.leaf, position: Offset(410, 25)),
        const MindMapNodeEntity(id: "technical", label: "Tech Stack", type: NodeType.branch, position: Offset(360, 210)),
        const MindMapNodeEntity(id: "business", label: "Business", type: NodeType.branch, position: Offset(170, 240)),
      ],
    ),
  ];
}
