import 'package:mindmapai/features/upgrade/domain/entities/credit_pack_entity.dart';
import 'package:mindmapai/features/upgrade/domain/entities/pro_plan_entity.dart';

abstract class UpgradeRepository {
  Future<List<CreditPackEntity>> getCreditPacks();
  Future<List<ProPlanEntity>> getProPlans(); // <-- НОВЫЙ МЕТОД
}
