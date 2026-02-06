import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/upgrade/domain/entities/credit_pack_entity.dart';
import 'package:mindmapai/features/upgrade/domain/usecases/get_credit_packs_usecase.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/upgrade_state.dart';

class UpgradeCubit extends Cubit<UpgradeState> {
  final GetCreditPacksUseCase _getCreditPacksUseCase;

  UpgradeCubit({required GetCreditPacksUseCase getCreditPacksUseCase})
      : _getCreditPacksUseCase = getCreditPacksUseCase,
        super(UpgradeInitial());

  Future<void> loadCreditPacks() async {
    emit(UpgradeLoading());
    try {
      final packs = await _getCreditPacksUseCase();
      if (packs.isEmpty) {
        emit(const UpgradeError("No credit packs available."));
        return;
      }
      // Find the "most popular" pack to select it by default
      final defaultPack = packs.firstWhere((p) => p.isMostPopular, orElse: () => packs.first);
      emit(UpgradeLoaded(packs: packs, selectedPack: defaultPack));
    } catch (e) {
      emit(const UpgradeError("Failed to load credit packs."));
    }
  }

  void selectPack(CreditPackEntity pack) {
    if (state is UpgradeLoaded) {
      final currentState = state as UpgradeLoaded;
      emit(currentState.copyWith(selectedPack: pack));
    }
  }
}
