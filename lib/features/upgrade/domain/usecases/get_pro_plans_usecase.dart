import 'package:mindmapai/features/upgrade/domain/entities/pro_plan_entity.dart';
import 'package:mindmapai/features/upgrade/domain/repositories/upgrade_repository.dart';

class GetProPlansUseCase {
  final UpgradeRepository repository;

  GetProPlansUseCase(this.repository);

  Future<List<ProPlanEntity>> call() {
    return repository.getProPlans();
  }
}
