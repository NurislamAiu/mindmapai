import 'package:equatable/equatable.dart';

class CreditPackEntity extends Equatable {
  final String id;
  final int credits;
  final String price;
  final String description;
  final bool isMostPopular;

  const CreditPackEntity({
    required this.id,
    required this.credits,
    required this.price,
    required this.description,
    this.isMostPopular = false,
  });

  @override
  List<Object?> get props => [id, credits, price, description, isMostPopular];
}
