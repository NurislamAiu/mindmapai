import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/help_support/domain/entities/contact_item.dart';
import 'package:mindmapai/features/help_support/domain/entities/faq_item.dart';
import 'package:mindmapai/features/help_support/domain/entities/legal_item.dart';
import 'package:mindmapai/features/help_support/domain/entities/quick_help_card.dart';
import 'package:mindmapai/features/help_support/domain/entities/help_support_data.dart';

abstract class HelpSupportLocalDataSource {
  Future<HelpSupportData> getHelpSupportData();
}

class HelpSupportLocalDataSourceImpl implements HelpSupportLocalDataSource {
  @override
  Future<HelpSupportData> getHelpSupportData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return HelpSupportData(
      quickHelpCards: _quickHelpCards,
      faqItems: _faqItems,
      contactItems: _contactItems,
      legalItems: _legalItems,
    );
  }

  final List<QuickHelpCard> _quickHelpCards = const [
    QuickHelpCard(
      icon: Iconsax.magicpen,
      title: "How AI credits work",
      description: "One credit equals one complete analysis",
      fullContent: "Each AI analysis requires 1 credit. Credits are deducted when you generate a new mind map or refine an existing idea.\n\nUnused credits from your Pro subscription roll over to the next month. One-time credit pack purchases never expire. You can check your current balance in the profile section.",
    ),
    QuickHelpCard(
      icon: Iconsax.clock,
      title: "Understanding version history",
      description: "Track how your ideas evolve over time",
      fullContent: "Every time you refine or update your mind map, a new version is automatically saved.\n\nYou can access all previous iterations in the version history panel. Restoring an older version simply makes it active—your newer work is also kept safe in history, so you never lose any progress.",
    ),
    QuickHelpCard(
      icon: Iconsax.refresh,
      title: "How refinement improves ideas",
      description: "Deepen your analysis with targeted improvements",
      fullContent: "Refinement allows you to guide the AI to focus on specific aspects of your idea.\n\nBy adding prompts like 'make it more actionable' or 'focus on marketing', the AI will regenerate the mind map with new depth and perspective while keeping your core concept intact. Each refinement creates a new version.",
    ),
    QuickHelpCard(
      icon: Iconsax.crown,
      title: "Managing your subscription",
      description: "View, upgrade, or cancel your plan",
      fullContent: "You can manage your Pro subscription directly from your device's app store settings.\n\nIf you choose to cancel, you will retain access to Pro features until the end of your current billing cycle. Your data and previous analyses will remain completely safe even if you switch to the free tier.",
    ),
  ];

  final List<FaqItem> _faqItems = const [
    FaqItem(
      question: "What is 1 AI credit used for?",
      answer: "One AI credit equals one complete idea analysis, which includes a full mind map visualization, key insights, and actionable recommendations. Each refinement of an existing idea also uses one credit.",
    ),
    FaqItem(
      question: "Do unused credits roll over?",
      answer: "Yes, if you have a Pro subscription, your unused credits roll over month to month. One-time credit pack purchases never expire.",
    ),
    FaqItem(
      question: "What happens when I restore a version?",
      answer: "When you restore a previous version, it becomes your current working version. The version you were working on is automatically saved in history, so you never lose any work.",
    ),
    FaqItem(
      question: "Can I cancel Pro anytime?",
      answer: "Yes, you can cancel your Pro subscription at any time from the settings screen. You'll continue to have Pro access until the end of your current billing period.",
    ),
    FaqItem(
      question: "How does the refinement feature work?",
      answer: "Refinement allows you to improve an existing analysis by focusing on specific aspects like depth, clarity, or new perspectives. Each refinement creates a new version while preserving the original.",
    ),
    FaqItem(
      question: "What's the difference between Standard and Deep analysis?",
      answer: "Standard analysis provides comprehensive insights suitable for most ideas. Deep analysis goes further with more detailed connections, deeper insights, and additional perspectives.",
    ),
    FaqItem(
      question: "Can I export my mind maps?",
      answer: "Pro subscribers can export mind maps as PDF or image files. This feature is available from the result screen after completing an analysis.",
    ),
    FaqItem(
      question: "How is my data protected?",
      answer: "All your ideas and analyses are encrypted and stored securely. We never share your data with third parties. You can export or delete your data at any time from settings.",
    ),
  ];

  final List<ContactItem> _contactItems = const [
    ContactItem(
      icon: Iconsax.sms,
      title: "Contact Support",
      subtitle: "Get help from our team",
    ),
    ContactItem(
      icon: Iconsax.message_edit,
      title: "Send Feedback",
      subtitle: "Share your thoughts with us",
    ),
    ContactItem(
      icon: Iconsax.warning_2,
      title: "Report a Problem",
      subtitle: "Let us know if something isn't working",
    ),
  ];

  final List<LegalItem> _legalItems = const [
    LegalItem(
      icon: Iconsax.shield_tick,
      title: "Privacy Policy",
    ),
    LegalItem(
      icon: Iconsax.document_text,
      title: "Terms of Service",
    ),
  ];
}
