import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum NodeStatus { added, modified, removed, unchanged }

enum NodeType { root, branch, leaf }

class MindMapNodeEntity extends Equatable {
  final String id;
  final String label;
  final NodeType type;
  final Offset position;
  final NodeStatus status;

  const MindMapNodeEntity({
    required this.id,
    required this.label,
    required this.type,
    required this.position,
    this.status = NodeStatus.unchanged,
  });

  MindMapNodeEntity copyWith({
    String? id,
    String? label,
    NodeType? type,
    Offset? position,
    NodeStatus? status,
  }) {
    return MindMapNodeEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      position: position ?? this.position,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, label, type, position, status];
}
