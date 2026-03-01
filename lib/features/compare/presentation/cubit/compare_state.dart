import 'package:equatable/equatable.dart';
import 'package:mindmapai/features/compare/domain/entities/mind_map_node_entity.dart';
import '../../domain/entities/mind_map_version_entity.dart';

enum CompareStatus { initial, loading, success, failure }

class CompareState extends Equatable {
  final CompareStatus status;
  final List<MindMapVersionEntity> allVersions;
  final MindMapVersionEntity? previousVersion;
  final MindMapVersionEntity? currentVersion;
  final List<MindMapNodeEntity> addedNodes;
  final List<MindMapNodeEntity> modifiedNodes;
  final List<MindMapNodeEntity> removedNodes;
  final String? error;

  const CompareState({
    this.status = CompareStatus.initial,
    this.allVersions = const [],
    this.previousVersion,
    this.currentVersion,
    this.addedNodes = const [],
    this.modifiedNodes = const [],
    this.removedNodes = const [],
    this.error,
  });

  CompareState copyWith({
    CompareStatus? status,
    List<MindMapVersionEntity>? allVersions,
    MindMapVersionEntity? previousVersion,
    MindMapVersionEntity? currentVersion,
    List<MindMapNodeEntity>? addedNodes,
    List<MindMapNodeEntity>? modifiedNodes,
    List<MindMapNodeEntity>? removedNodes,
    String? error,
  }) {
    return CompareState(
      status: status ?? this.status,
      allVersions: allVersions ?? this.allVersions,
      previousVersion: previousVersion ?? this.previousVersion,
      currentVersion: currentVersion ?? this.currentVersion,
      addedNodes: addedNodes ?? this.addedNodes,
      modifiedNodes: modifiedNodes ?? this.modifiedNodes,
      removedNodes: removedNodes ?? this.removedNodes,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allVersions,
        previousVersion,
        currentVersion,
        addedNodes,
        modifiedNodes,
        removedNodes,
        error,
      ];
}
