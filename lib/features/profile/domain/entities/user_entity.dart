import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final int ideasAnalyzed;
  final int daysActive;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.ideasAnalyzed,
    required this.daysActive,
  });

  @override
  List<Object?> get props => [id, name, email, ideasAnalyzed, daysActive];
}
