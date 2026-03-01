import 'package:equatable/equatable.dart';

enum ChangeType { initial, refinement, major }

class VersionEntity extends Equatable {
  final String id;
  final String label;
  final DateTime timestamp;
  final String description;
  final ChangeType changeType;
  final String summary;
  final int previewNodes;

  const VersionEntity({
    required this.id,
    required this.label,
    required this.timestamp,
    required this.description,
    required this.changeType,
    required this.summary,
    required this.previewNodes,
  });

  @override
  List<Object?> get props => [id, label, timestamp, description, changeType, summary, previewNodes];
}
