import 'package:mindmapai/features/help_support/domain/entities/contact_item.dart';
import 'package:mindmapai/features/help_support/domain/entities/faq_item.dart';
import 'package:mindmapai/features/help_support/domain/entities/legal_item.dart';
import 'package:mindmapai/features/help_support/domain/entities/quick_help_card.dart';

class HelpSupportData {
  final List<QuickHelpCard> quickHelpCards;
  final List<FaqItem> faqItems;
  final List<ContactItem> contactItems;
  final List<LegalItem> legalItems;

  const HelpSupportData({
    required this.quickHelpCards,
    required this.faqItems,
    required this.contactItems,
    required this.legalItems,
  });
}
