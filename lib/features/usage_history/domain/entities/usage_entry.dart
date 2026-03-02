enum ActionType {
  initial,
  refinement,
  deep,
  compare,
}

class UsageEntry {
  final String id;
  final String ideaName;
  final ActionType actionType;
  final int creditsUsed;
  final DateTime timestamp;

  const UsageEntry({
    required this.id,
    required this.ideaName,
    required this.actionType,
    required this.creditsUsed,
    required this.timestamp,
  });
  
  // Добавлены моковые данные для отображения UI
  static List<UsageEntry> get mockEntries {
    final now = DateTime.now();
    
    return [
      UsageEntry(
        id: '1',
        ideaName: 'E-commerce App Idea',
        actionType: ActionType.initial,
        creditsUsed: 1,
        timestamp: now.subtract(const Duration(hours: 2)),
      ),
      UsageEntry(
        id: '2',
        ideaName: 'Smart Home Hub',
        actionType: ActionType.deep,
        creditsUsed: 3,
        timestamp: now.subtract(const Duration(hours: 5)),
      ),
      UsageEntry(
        id: '3',
        ideaName: 'Fitness Tracker Refinement',
        actionType: ActionType.refinement,
        creditsUsed: 1,
        timestamp: now.subtract(const Duration(days: 1, hours: 3)),
      ),
      UsageEntry(
        id: '4',
        ideaName: 'Food Delivery Analytics',
        actionType: ActionType.compare,
        creditsUsed: 2,
        timestamp: now.subtract(const Duration(days: 1, hours: 8)),
      ),
      UsageEntry(
        id: '5',
        ideaName: 'SaaS Dashboard',
        actionType: ActionType.initial,
        creditsUsed: 1,
        timestamp: now.subtract(const Duration(days: 2, hours: 1)),
      ),
      UsageEntry(
        id: '6',
        ideaName: 'AI Chatbot Integration',
        actionType: ActionType.deep,
        creditsUsed: 3,
        timestamp: now.subtract(const Duration(days: 2, hours: 6)),
      ),
      UsageEntry(
        id: '7',
        ideaName: 'Language Learning App',
        actionType: ActionType.refinement,
        creditsUsed: 1,
        timestamp: now.subtract(const Duration(days: 3, hours: 4)),
      ),
    ];
  }
}
