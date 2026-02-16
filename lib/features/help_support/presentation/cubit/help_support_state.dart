import 'package:equatable/equatable.dart';
import 'package:mindmapai/features/help_support/domain/entities/help_support_data.dart';

abstract class HelpSupportState extends Equatable {
  const HelpSupportState();

  @override
  List<Object> get props => [];
}

class HelpSupportInitial extends HelpSupportState {}

class HelpSupportLoading extends HelpSupportState {}

class HelpSupportLoaded extends HelpSupportState {
  final HelpSupportData data;

  const HelpSupportLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class HelpSupportError extends HelpSupportState {
  final String message;

  const HelpSupportError({required this.message});

  @override
  List<Object> get props => [message];
}
