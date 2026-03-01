class StartupAnalysis {
  final String ideaTitle;
  final String timestamp;
  final int overallScore;
  final int readinessPercent;
  final String weakestArea;
  final String riskLevel;
  final List<StartupBranch> branches;
  final NextAction nextAction;
  final List<ActionItem> actionItems;

  const StartupAnalysis({
    required this.ideaTitle,
    required this.timestamp,
    required this.overallScore,
    required this.readinessPercent,
    required this.weakestArea,
    required this.riskLevel,
    required this.branches,
    required this.nextAction,
    required this.actionItems,
  });
}

class StartupBranch {
  final String id;
  final String title;
  final int score;
  final List<String> bullets;
  final String color;

  const StartupBranch({
    required this.id,
    required this.title,
    required this.score,
    required this.bullets,
    required this.color,
  });
}

class NextAction {
  final String title;
  final String description;

  const NextAction({
    required this.title,
    required this.description,
  });
}

class ActionItem {
  final String title;
  final String priority;
  final String effort;

  const ActionItem({
    required this.title,
    required this.priority,
    required this.effort,
  });
}
