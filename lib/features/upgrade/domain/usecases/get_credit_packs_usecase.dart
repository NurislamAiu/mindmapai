import 'package:mindmapai/features/upgrade/domain/entities/credit_pack_entity.dart';
import 'package:mindmapai/features/upgrade/domain/repositories/upgrade_repository.dart';

class GetCreditPacksUseCase {
  final UpgradeRepository repository;

  GetCreditPacksUseCase(this.repository);

  Future<List<CreditPackEntity>> call() {
    return repository.getCreditPacks();
  }
}
