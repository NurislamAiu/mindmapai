import 'package:equatable/equatable.dart';
import 'package:mindmapai/features/upgrade/domain/entities/credit_pack_entity.dart';

abstract class UpgradeState extends Equatable {
  const UpgradeState();

  @override
  List<Object?> get props => [];
}

class UpgradeInitial extends UpgradeState {}

class UpgradeLoading extends UpgradeState {}

class UpgradeLoaded extends UpgradeState {
  final List<CreditPackEntity> packs;
  final CreditPackEntity selectedPack;

  const UpgradeLoaded({required this.packs, required this.selectedPack});

  @override
  List<Object?> get props => [packs, selectedPack];

  UpgradeLoaded copyWith({
    List<CreditPackEntity>? packs,
    CreditPackEntity? selectedPack,
  }) {
    return UpgradeLoaded(
      packs: packs ?? this.packs,
      selectedPack: selectedPack ?? this.selectedPack,
    );
  }
}

class UpgradeError extends UpgradeState {
  final String message;

  const UpgradeError(this.message);

  @override
  List<Object?> get props => [message];
}
