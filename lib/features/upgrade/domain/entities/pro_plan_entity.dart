import 'package:equatable/equatable.dart';

class ProPlanEntity extends Equatable {
  final String id;
  final String title;
  final String price;
  final String billingCycle; // e.g., "/ monthly" or "/ yearly"
  final String? badge; // e.g., "Best Value"
  final List<String> features;

  const ProPlanEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.billingCycle,
    this.badge,
    required this.features,
  });

  @override
  List<Object?> get props => [id, title, price, billingCycle, badge, features];
}
