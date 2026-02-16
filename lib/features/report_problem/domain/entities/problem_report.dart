import 'dart:io';

import 'package:equatable/equatable.dart';

class ProblemReport extends Equatable {
  final String category;
  final String description;
  final File? screenshot;

  const ProblemReport({
    required this.category,
    required this.description,
    this.screenshot,
  });

  @override
  List<Object?> get props => [category, description, screenshot];
}
