import 'package:flutter/material.dart';
import '../../../home/domain/entities/idea.dart';
import '../../../home/domain/usecases/get_all_ideas.dart';

enum IdeaFilter { All, Analyzed, Drafts }

class IdeasProvider with ChangeNotifier {
  final GetAllIdeas _getAllIdeas;

  IdeasProvider({required GetAllIdeas getAllIdeas}) : _getAllIdeas = getAllIdeas;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;
  
  List<Idea> _allIdeas = [];
  List<Idea> get filteredIdeas {
    switch (_activeFilter) {
      case IdeaFilter.Analyzed:
        return _allIdeas.where((i) => i.status == IdeaStatus.Analyzed).toList();
      case IdeaFilter.Drafts:
        return _allIdeas.where((i) => i.status == IdeaStatus.Draft).toList();
      case IdeaFilter.All:
      default:
        return _allIdeas;
    }
  }

  IdeaFilter _activeFilter = IdeaFilter.All;
  IdeaFilter get activeFilter => _activeFilter;

  Future<void> fetchIdeas() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allIdeas = await _getAllIdeas();
    } catch (e) {
      _error = "Failed to load ideas.";
    }
    _isLoading = false;
    notifyListeners();
  }

  void setFilter(IdeaFilter filter) {
    if (_activeFilter == filter) return;
    _activeFilter = filter;
    notifyListeners();
  }
}
