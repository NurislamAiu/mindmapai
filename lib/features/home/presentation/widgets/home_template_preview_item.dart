import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/home/domain/entities/template_preview.dart';

class HomeTemplatePreviewItem extends StatelessWidget {
  final TemplatePreview template;

  const HomeTemplatePreviewItem({
    super.key,
    required this.template,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.0),
      child: InkWell(
        onTap: () {
          // TODO: Handle template selection
        },
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: const Color(0xFFF0F0F5)),
          ),
          child: Row(
            children: [
              _buildIcon(),
              const SizedBox(width: 16),
              _buildTextContent(),
              const Icon(Iconsax.arrow_right_3, color: Color(0xFF9CA3AF)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Icon(template.icon, color: const Color(0xFF4F46E5)),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            template.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            template.subtitle,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
