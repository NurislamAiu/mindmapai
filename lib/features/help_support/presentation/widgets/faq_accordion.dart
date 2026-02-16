import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindmapai/features/help_support/domain/entities/faq_item.dart';

class FaqAccordion extends StatefulWidget {
  final List<FaqItem> faqItems;

  const FaqAccordion({Key? key, required this.faqItems}) : super(key: key);

  @override
  State<FaqAccordion> createState() => _FaqAccordionState();
}

class _FaqAccordionState extends State<FaqAccordion> {
  int _openIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.faqItems.length, (index) {
        final item = widget.faqItems[index];
        final bool isExpanded = _openIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              _openIndex = isExpanded ? -1 : index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isExpanded ? Colors.white : const Color(0xFFFDFDFD),
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: isExpanded ? Colors.indigo.shade100.withOpacity(0.8) : Colors.grey.shade200.withOpacity(0.8),
                width: 1.2,
              ),
              boxShadow: isExpanded ? [
                BoxShadow(
                  color: Colors.indigo.shade100.withOpacity(0.3),
                  blurRadius: 25,
                  offset: const Offset(0, 8),
                ),
              ] : [],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.question,
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: isExpanded ? const Color(0xFF1E2749) : const Color(0xFF344054),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isExpanded ? Colors.indigo.shade50 : Colors.transparent,
                        ),
                        child: AnimatedRotation(
                          turns: isExpanded ? -0.5 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            Icons.expand_more_rounded,
                            size: 24,
                            color: isExpanded ? Colors.indigo.shade500 : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isExpanded)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 24),
                      child: Text(
                        item.answer,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w300,
                          height: 1.6,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 500.ms, curve: Curves.easeOutCubic)
                    .slideY(begin: -0.1, duration: 500.ms, curve: Curves.easeOutCubic),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
