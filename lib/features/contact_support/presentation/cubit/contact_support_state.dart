import 'package:equatable/equatable.dart';

abstract class ContactSupportState extends Equatable {
  const ContactSupportState();

  @override
  List<Object> get props => [];
}

class ContactSupportInitial extends ContactSupportState {}

class ContactSupportLoading extends ContactSupportState {}

class ContactSupportSuccess extends ContactSupportState {}

class ContactSupportError extends ContactSupportState {
  final String message;

  const ContactSupportError(this.message);

  @override
  List<Object> get props => [message];
}
