import 'package:equatable/equatable.dart';

enum SubscriptionStatus { free, pro }

class UserProfile extends Equatable {
  final String name;
  final String email;
  final SubscriptionStatus subscriptionStatus;
  final int credits;

  const UserProfile({
    required this.name,
    required this.email,
    required this.subscriptionStatus,
    required this.credits,
  });

  @override
  List<Object?> get props => [name, email, subscriptionStatus, credits];
}
