import 'package:equatable/equatable.dart';

enum AnalysisDepth { standard, deep }
enum MindMapLayout { radial, tree, organic }

class UserSettings extends Equatable {
  final AnalysisDepth analysisDepth;
  final MindMapLayout mindMapLayout;
  final bool autoSaveVersions;
  final bool hapticFeedback;

  const UserSettings({
    required this.analysisDepth,
    required this.mindMapLayout,
    required this.autoSaveVersions,
    required this.hapticFeedback,
  });

  UserSettings copyWith({
    AnalysisDepth? analysisDepth,
    MindMapLayout? mindMapLayout,
    bool? autoSaveVersions,
    bool? hapticFeedback,
  }) {
    return UserSettings(
      analysisDepth: analysisDepth ?? this.analysisDepth,
      mindMapLayout: mindMapLayout ?? this.mindMapLayout,
      autoSaveVersions: autoSaveVersions ?? this.autoSaveVersions,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
    );
  }

  @override
  List<Object?> get props => [analysisDepth, mindMapLayout, autoSaveVersions, hapticFeedback];
}
