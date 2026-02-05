import 'package:flutter/material.dart';
import '../../domain/entities/template.dart';
import '../../domain/usecases/get_explore_data.dart';

class ExploreProvider with ChangeNotifier {
  final GetExploreData _getExploreData;

  ExploreProvider({required GetExploreData getExploreData}) : _getExploreData = getExploreData;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Template? recommendedTemplate;
  List<Template> popularTemplates = [];

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final (recommended, popular) = await _getExploreData();
      recommendedTemplate = recommended;
      popularTemplates = popular;
    } catch (e) {
      _error = "Failed to load templates.";
    }
    _isLoading = false;
    notifyListeners();
  }
}
