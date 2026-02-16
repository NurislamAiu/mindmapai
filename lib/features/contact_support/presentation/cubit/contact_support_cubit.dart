import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/contact_support/domain/entities/support_message.dart';
import 'package:mindmapai/features/contact_support/domain/usecases/send_message.dart';
import 'package:mindmapai/features/contact_support/presentation/cubit/contact_support_state.dart';

class ContactSupportCubit extends Cubit<ContactSupportState> {
  final SendMessage sendMessageUseCase;

  ContactSupportCubit({required this.sendMessageUseCase}) : super(ContactSupportInitial());

  Future<void> sendMessage({
    required String category,
    required String email,
    required String message,
  }) async {
    emit(ContactSupportLoading());
    try {
      final supportMessage = SupportMessage(
        category: category,
        email: email,
        message: message,
      );
      await sendMessageUseCase(supportMessage);
      emit(ContactSupportSuccess());
    } catch (e) {
      emit(ContactSupportError('Failed to send message: ${e.toString()}'));
    }
  }
}
