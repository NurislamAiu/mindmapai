import 'package:mindmapai/features/upgrade/domain/entities/credit_pack_entity.dart';
import 'package:mindmapai/features/upgrade/domain/entities/pro_plan_entity.dart';
import 'package:mindmapai/features/upgrade/domain/repositories/upgrade_repository.dart';

class UpgradeRepositoryImpl implements UpgradeRepository {
  @override
  Future<List<CreditPackEntity>> getCreditPacks() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const [
      CreditPackEntity(id: "small", credits: 5, price: "\$4.99", description: "Best for a few ideas"),
      CreditPackEntity(id: "medium", credits: 15, price: "\$12.99", description: "Most popular", isMostPopular: true),
      CreditPackEntity(id: "large", credits: 50, price: "\$29.99", description: "Best value"),
    ];
  }

  // <-- НОВАЯ РЕАЛИЗАЦИЯ -->
  @override
  Future<List<ProPlanEntity>> getProPlans() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      ProPlanEntity(
        id: "yearly",
        title: "Yearly",
        price: "\$59.99",
        billingCycle: "/ year",
        badge: "Save 40%",
        features: [
          "25 monthly credits",
          "Ad-free experience",
          "Advanced export options",
          "Priority support",
        ],
      ),
      ProPlanEntity(
        id: "monthly",
        title: "Monthly",
        price: "\$9.99",
        billingCycle: "/ month",
        features: [
          "20 monthly credits",
          "Ad-free experience",
          "Advanced export options",
        ],
      ),
    ];
  }
}
