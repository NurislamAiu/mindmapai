import 'package:mindmapai/features/contact_support/domain/entities/support_message.dart';
import 'package:mindmapai/features/contact_support/domain/repositories/contact_support_repository.dart';

class ContactSupportRepositoryImpl implements ContactSupportRepository {
  @override
  Future<void> sendMessage(SupportMessage message) async {
    // Simulate network request
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, you would send the message to your backend here.
    print('Sending message: ${message.category}, ${message.email}, ${message.message}');
  }
}
