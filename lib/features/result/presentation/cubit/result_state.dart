import 'package:equatable/equatable.dart';
import '../../domain/entities/startup_analysis.dart';

enum ViewMode { map, business, action }

abstract class ResultState extends Equatable {
  const ResultState();

  @override
  List<Object?> get props => [];
}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultLoaded extends ResultState {
  final StartupAnalysis data;
  final ViewMode viewMode;
  final Set<String> expandedCards;
  final StartupBranch? selectedBranch;

  const ResultLoaded({
    required this.data,
    this.viewMode = ViewMode.map,
    this.expandedCards = const {'problem'},
    this.selectedBranch,
  });

  ResultLoaded copyWith({
    StartupAnalysis? data,
    ViewMode? viewMode,
    Set<String>? expandedCards,
    StartupBranch? selectedBranch,
    bool clearSelectedBranch = false,
  }) {
    return ResultLoaded(
      data: data ?? this.data,
      viewMode: viewMode ?? this.viewMode,
      expandedCards: expandedCards ?? this.expandedCards,
      selectedBranch: clearSelectedBranch ? null : (selectedBranch ?? this.selectedBranch),
    );
  }

  @override
  List<Object?> get props => [data, viewMode, expandedCards, selectedBranch];
}

class ResultError extends ResultState {
  final String message;
  const ResultError(this.message);

  @override
  List<Object> get props => [message];
}
