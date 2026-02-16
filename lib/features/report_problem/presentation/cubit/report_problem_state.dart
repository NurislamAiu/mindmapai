import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ReportProblemState extends Equatable {
  const ReportProblemState();

  @override
  List<Object?> get props => [];
}

class ReportProblemInitial extends ReportProblemState {}

class ReportProblemLoading extends ReportProblemState {}

class ReportProblemSuccess extends ReportProblemState {}

class ReportProblemError extends ReportProblemState {
  final String message;

  const ReportProblemError(this.message);

  @override
  List<Object> get props => [message];
}

class ScreenshotPicked extends ReportProblemState {
  final File screenshot;

  const ScreenshotPicked(this.screenshot);

  @override
  List<Object?> get props => [screenshot];
}
