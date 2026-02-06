import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/upgrade/domain/entities/pro_plan_entity.dart';
import 'package:mindmapai/features/upgrade/domain/usecases/get_pro_plans_usecase.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/go_pro_state.dart';

class GoProCubit extends Cubit<GoProState> {
  final GetProPlansUseCase _getProPlansUseCase;

  GoProCubit({required GetProPlansUseCase getProPlansUseCase})
      : _getProPlansUseCase = getProPlansUseCase,
        super(GoProInitial());

  Future<void> loadPlans() async {
    emit(GoProLoading());
    try {
      final plans = await _getProPlansUseCase();
      if (plans.isEmpty) {
        emit(const GoProError("No subscription plans available."));
        return;
      }
      // Select "Yearly" plan by default as it's the best value
      final defaultPlan = plans.firstWhere((p) => p.id == 'yearly', orElse: () => plans.first);
      emit(GoProLoaded(plans: plans, selectedPlan: defaultPlan));
    } catch (e) {
      emit(const GoProError("Failed to load subscription plans."));
    }
  }

  void selectPlan(ProPlanEntity plan) {
    if (state is GoProLoaded) {
      final currentState = state as GoProLoaded;
      emit(currentState.copyWith(selectedPlan: plan));
    }
  }
}
