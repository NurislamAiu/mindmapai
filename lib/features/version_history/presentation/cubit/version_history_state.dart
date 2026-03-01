import 'package:equatable/equatable.dart';
import '../../domain/entities/version_entity.dart';

enum VersionHistoryStatus { initial, loading, success, failure }

class VersionHistoryState extends Equatable {
  final VersionHistoryStatus status;
  final List<VersionEntity> versions;
  final String? selectedVersionId;
  final String? error;

  const VersionHistoryState({
    this.status = VersionHistoryStatus.initial,
    this.versions = const <VersionEntity>[],
    this.selectedVersionId,
    this.error,
  });

  VersionHistoryState copyWith({
    VersionHistoryStatus? status,
    List<VersionEntity>? versions,
    String? selectedVersionId,
    bool clearSelectedVersion = false,
    String? error,
  }) {
    return VersionHistoryState(
      status: status ?? this.status,
      versions: versions ?? this.versions,
      selectedVersionId: clearSelectedVersion ? null : selectedVersionId ?? this.selectedVersionId,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, versions, selectedVersionId, error];
}
