import 'package:equatable/equatable.dart';
import 'package:mindmapai/features/upgrade/domain/entities/pro_plan_entity.dart';

abstract class GoProState extends Equatable {
  const GoProState();

  @override
  List<Object?> get props => [];
}

class GoProInitial extends GoProState {}

class GoProLoading extends GoProState {}

class GoProLoaded extends GoProState {
  final List<ProPlanEntity> plans;
  final ProPlanEntity selectedPlan;

  const GoProLoaded({required this.plans, required this.selectedPlan});

  @override
  List<Object?> get props => [plans, selectedPlan];

  GoProLoaded copyWith({
    List<ProPlanEntity>? plans,
    ProPlanEntity? selectedPlan,
  }) {
    return GoProLoaded(
      plans: plans ?? this.plans,
      selectedPlan: selectedPlan ?? this.selectedPlan,
    );
  }
}

class GoProError extends GoProState {
  final String message;

  const GoProError(this.message);

  @override
  List<Object?> get props => [message];
}
