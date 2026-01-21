enum IdeaStatus { Analyzed, Draft }

class Idea {
  final int id;
  final String title;
  final String summary;
  final String date;
  final IdeaStatus status;

  Idea({
    required this.id,
    required this.title,
    required this.summary,
    required this.date,
    required this.status,
  });
}
