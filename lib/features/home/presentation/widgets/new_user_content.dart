import 'package:flutter/material.dart';
import 'package:mindmapai/features/home/domain/entities/template_preview.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_empty_state.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_page_indicator.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_template_preview_item.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_why_use_templates_card.dart';

class NewUserContent extends StatefulWidget {
  const NewUserContent({super.key, required this.templates});

  final List<TemplatePreview> templates;

  @override
  State<NewUserContent> createState() => _NewUserContentState();
}

class _NewUserContentState extends State<NewUserContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const HomeEmptyState(),
        const SizedBox(height: 16),
        const Text(
          'Start with a Template',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.templates.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: HomeTemplatePreviewItem(
                  template: widget.templates[index],
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        HomePageIndicator(
          pageCount: widget.templates.length,
          currentPage: _currentPage,
        ),
        const SizedBox(height: 16),
        const HomeWhyUseTemplatesCard(),
      ],
    );
  }
}
