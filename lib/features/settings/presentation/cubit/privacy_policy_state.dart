import 'package:equatable/equatable.dart';

abstract class PrivacyPolicyState extends Equatable {
  const PrivacyPolicyState();

  @override
  List<Object> get props => [];
}

class PrivacyPolicyInitial extends PrivacyPolicyState {}

class PrivacyPolicyLoading extends PrivacyPolicyState {}

class PrivacyPolicyLoaded extends PrivacyPolicyState {
  final String markdownData;

  const PrivacyPolicyLoaded(this.markdownData);

  @override
  List<Object> get props => [markdownData];
}

class PrivacyPolicyError extends PrivacyPolicyState {
  final String message;

  const PrivacyPolicyError(this.message);

  @override
  List<Object> get props => [message];
}
