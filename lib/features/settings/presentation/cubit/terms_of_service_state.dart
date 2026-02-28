import 'package:equatable/equatable.dart';

abstract class TermsOfServiceState extends Equatable {
  const TermsOfServiceState();

  @override
  List<Object> get props => [];
}

class TermsOfServiceInitial extends TermsOfServiceState {}

class TermsOfServiceLoading extends TermsOfServiceState {}

class TermsOfServiceLoaded extends TermsOfServiceState {
  final String markdownData;

  const TermsOfServiceLoaded(this.markdownData);

  @override
  List<Object> get props => [markdownData];
}

class TermsOfServiceError extends TermsOfServiceState {
  final String message;

  const TermsOfServiceError(this.message);

  @override
  List<Object> get props => [message];
}
