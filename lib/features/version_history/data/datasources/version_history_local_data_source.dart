import '../../domain/entities/version_entity.dart';

abstract class VersionHistoryLocalDataSource {
  Future<List<VersionEntity>> getVersions();
}

class VersionHistoryLocalDataSourceImpl implements VersionHistoryLocalDataSource {
  @override
  Future<List<VersionEntity>> getVersions() async {
    // Имитируем задержку сети
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Моковые данные, как в React-компоненте
    return [
      VersionEntity(
        id: "v4",
        label: "Version 4",
        timestamp: DateTime(2024, 7, 21, 14, 30),
        description: "Expanded technical approach and identified potential risks",
        changeType: ChangeType.refinement,
        summary: "Added deeper analysis of technical architecture decisions, including infrastructure considerations and team requirements. Surfaced potential risks around content licensing and user retention.",
        previewNodes: 16,
      ),
      VersionEntity(
        id: "v3",
        label: "Version 3",
        timestamp: DateTime(2024, 7, 21, 11, 15),
        description: "Refined business model with B2B focus",
        changeType: ChangeType.major,
        summary: "Restructured the business model to emphasize corporate wellness partnerships alongside direct-to-consumer offerings. Added detailed revenue projections and customer acquisition strategies.",
        previewNodes: 14,
      ),
      VersionEntity(
        id: "v2",
        label: "Version 2",
        timestamp: DateTime(2024, 7, 20, 16, 45),
        description: "Clarified target audience and core features",
        changeType: ChangeType.refinement,
        summary: "Refined the target audience definition to focus on high-stress professions. Expanded core features section with more specific functionality details and user experience considerations.",
        previewNodes: 12,
      ),
      VersionEntity(
        id: "v1",
        label: "Version 1",
        timestamp: DateTime(2024, 7, 19, 10, 20),
        description: "Initial AI analysis",
        changeType: ChangeType.initial,
        summary: "First comprehensive analysis of the meditation app idea, covering core features, target audience, technical approach, and business model. Established the foundation for future refinements.",
        previewNodes: 10,
      ),
    ];
  }
}
