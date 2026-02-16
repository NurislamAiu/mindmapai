import 'package:equatable/equatable.dart';

class Feedback extends Equatable {
  final int? rating;
  final String feedback;

  const Feedback({
    this.rating,
    required this.feedback,
  });

  @override
  List<Object?> get props => [rating, feedback];
}
