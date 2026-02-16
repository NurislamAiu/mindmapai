import 'package:mindmapai/features/contact_support/domain/entities/support_message.dart';
import 'package:mindmapai/features/contact_support/domain/repositories/contact_support_repository.dart';

class SendMessage {
  final ContactSupportRepository repository;

  SendMessage(this.repository);

  Future<void> call(SupportMessage message) async {
    return await repository.sendMessage(message);
  }
}
