import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/compare/domain/entities/mind_map_node_entity.dart';
import 'package:mindmapai/features/compare/domain/entities/mind_map_version_entity.dart';
import '../../domain/usecases/get_all_versions.dart';
import 'compare_state.dart';

class CompareCubit extends Cubit<CompareState> {
  final GetAllVersions _getAllVersions;

  CompareCubit({required GetAllVersions getAllVersions})
      : _getAllVersions = getAllVersions,
        super(const CompareState());

  Future<void> loadAllVersions(String ideaId, {String? initialPreviousId, String? initialCurrentId}) async {
    emit(state.copyWith(status: CompareStatus.loading));
    try {
      final versions = await _getAllVersions(ideaId);
      final prevVersion = versions.firstWhere((v) => v.id == (initialPreviousId ?? 'v3'), orElse: () => versions[1]);
      final currVersion = versions.firstWhere((v) => v.id == (initialCurrentId ?? 'v4'), orElse: () => versions[0]);

      emit(state.copyWith(
        status: CompareStatus.success,
        allVersions: versions,
        previousVersion: prevVersion,
        currentVersion: currVersion,
      ));
      _calculateChanges();
    } catch (e) {
      emit(state.copyWith(status: CompareStatus.failure, error: e.toString()));
    }
  }

  void setPreviousVersion(String versionId) {
    final newVersion = state.allVersions.firstWhere((v) => v.id == versionId);
    emit(state.copyWith(previousVersion: newVersion));
    _calculateChanges();
  }

  void setCurrentVersion(String versionId) {
    final newVersion = state.allVersions.firstWhere((v) => v.id == versionId);
    emit(state.copyWith(currentVersion: newVersion));
    _calculateChanges();
  }

  void _calculateChanges() {
    final prev = state.previousVersion;
    final curr = state.currentVersion;
    if (prev == null || curr == null) return;

    final prevNodesMap = {for (var node in prev.nodes) node.id: node};
    final currNodesMap = {for (var node in curr.nodes) node.id: node};

    final added = <MindMapNodeEntity>[];
    final modified = <MindMapNodeEntity>[];
    
    currNodesMap.forEach((id, currNode) {
      if (!prevNodesMap.containsKey(id)) {
        added.add(currNode);
      } else {
        final prevNode = prevNodesMap[id]!;
        if (prevNode.label != currNode.label) {
          modified.add(currNode);
        }
      }
    });

    final removed = <MindMapNodeEntity>[];
    prevNodesMap.forEach((id, prevNode) {
      if (!currNodesMap.containsKey(id)) {
        removed.add(prevNode);
      }
    });
    
    emit(state.copyWith(
      addedNodes: added,
      modifiedNodes: modified,
      removedNodes: removed,
    ));
  }
}
