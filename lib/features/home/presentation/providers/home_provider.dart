import 'package:flutter/material.dart';
import '../../../home/domain/entities/home_screen_data.dart';
import '../../../home/domain/usecases/get_home_screen_data.dart';

enum HomeState { initial, loading, loaded, error }

class HomeProvider with ChangeNotifier {
  final GetHomeScreenData getHomeScreenData;

  HomeProvider({required this.getHomeScreenData});

  HomeState _state = HomeState.initial;
  HomeState get state => _state;

  HomeScreenData? _data;
  HomeScreenData? get data => _data;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchData() async {
    _state = HomeState.loading;
    notifyListeners();
    try {
      _data = await getHomeScreenData();
      _state = HomeState.loaded;
    } catch (e) {
      _state = HomeState.error;
      _errorMessage = "Failed to load data.";
    }
    notifyListeners();
  }
}
