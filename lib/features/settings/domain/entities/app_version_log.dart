class AppVersionLog {
  final String version;
  final String buildNumber;
  final DateTime releaseDate;
  final List<String> newFeatures;
  final List<String> improvements;
  final List<String> bugFixes;

  const AppVersionLog({
    required this.version,
    required this.buildNumber,
    required this.releaseDate,
    this.newFeatures = const [],
    this.improvements = const [],
    this.bugFixes = const [],
  });

  static List<AppVersionLog> get mockHistory {
    return [
      AppVersionLog(
        version: '1.2.0',
        buildNumber: '42',
        releaseDate: DateTime.now().subtract(const Duration(days: 2)),
        newFeatures: [
          'Added App Version History screen',
          'Introduced Usage History to track AI credits',
        ],
        improvements: [
          'UI performance improvements on the Home screen',
          'Updated animations for smoother transitions',
        ],
        bugFixes: [
          'Fixed an issue with AI credits not syncing instantly',
        ],
      ),
      AppVersionLog(
        version: '1.1.0',
        buildNumber: '38',
        releaseDate: DateTime.now().subtract(const Duration(days: 15)),
        newFeatures: [
          'Added Deep Analysis mode for complex ideas',
          'Compare mode: now you can compare different versions of mind maps',
        ],
        improvements: [
          'Enhanced AI prompts for more accurate responses',
          'Improved contrast in Dark Mode',
        ],
      ),
      AppVersionLog(
        version: '1.0.0',
        buildNumber: '30',
        releaseDate: DateTime.now().subtract(const Duration(days: 45)),
        newFeatures: [
          'Initial release of MindMap AI',
          'AI-powered mind map generation',
          'Export to PDF and image formats',
        ],
        bugFixes: [
          'General stability improvements',
        ],
      ),
    ];
  }
}
