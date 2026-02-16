import 'package:mindmapai/features/contact_support/domain/entities/support_message.dart';

abstract class ContactSupportRepository {
  Future<void> sendMessage(SupportMessage message);
}
