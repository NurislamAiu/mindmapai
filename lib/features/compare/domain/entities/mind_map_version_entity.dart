import 'package:equatable/equatable.dart';
import 'mind_map_node_entity.dart';

class MindMapVersionEntity extends Equatable {
  final String id;
  final String label;
  final String timestamp;
  final List<MindMapNodeEntity> nodes;

  const MindMapVersionEntity({
    required this.id,
    required this.label,
    required this.timestamp,
    required this.nodes,
  });

  @override
  List<Object?> get props => [id, label, timestamp, nodes];
}
