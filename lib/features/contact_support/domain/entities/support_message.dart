import 'package:equatable/equatable.dart';

class SupportMessage extends Equatable {
  final String category;
  final String email;
  final String message;

  const SupportMessage({
    required this.category,
    required this.email,
    required this.message,
  });

  @override
  List<Object?> get props => [category, email, message];
}
