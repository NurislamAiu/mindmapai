import '../../domain/entities/usage_entry.dart';

class DateFormatter {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(today.year, today.month, today.day - 1);
    
    final entryDate = DateTime(date.year, date.month, date.day);
    
    if (entryDate == today) {
      return "Today";
    } else if (entryDate == yesterday) {
      return "Yesterday";
    } else {
      return '${_months[date.month - 1]} ${date.day}';
    }
  }

  static String formatTime(DateTime date) {
    String hour = (date.hour % 12 == 0 ? 12 : date.hour % 12).toString();
    String minute = date.minute.toString().padLeft(2, '0');
    String period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  static Map<String, List<UsageEntry>> groupEntriesByDate(List<UsageEntry> entries) {
    final grouped = <String, List<UsageEntry>>{};
    
    for (var entry in entries) {
      final dateKey = formatDate(entry.timestamp);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(entry);
    }
    
    return grouped;
  }
}
