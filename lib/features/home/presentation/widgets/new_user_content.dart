import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/home/domain/entities/template_preview.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_empty_state.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_page_indicator.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_showcase_section.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_template_preview_item.dart';
import 'package:mindmapai/features/home/presentation/widgets/templates_explainer_sheet.dart';

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

  void _showExplainerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => const TemplatesExplainerSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const HomeEmptyState(),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Start with a Template',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          clipBehavior: Clip.none,
          children: [
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
            Positioned(
              top: 0,
              left: 15 + 4.0, // 15 + horizontal padding
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _currentPage == 0 ? 1.0 : 0.0,
                child: _ExplainerHint(onTap: _showExplainerSheet),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        HomePageIndicator(
          pageCount: widget.templates.length,
          currentPage: _currentPage,
        ),
        const SizedBox(height: 24),
        const HomeShowcaseSection(),
      ],
    );
  }
}

class _ExplainerHint extends StatefulWidget {
  final VoidCallback onTap;
  const _ExplainerHint({required this.onTap});

  @override
  __ExplainerHintState createState() => __ExplainerHintState();
}

class __ExplainerHintState extends State<_ExplainerHint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Transform.translate(
        offset: const Offset(0, -12),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.7, end: 1.0).animate(_controller),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF6366F1),
              boxShadow: [
                BoxShadow(
                  color: Color(0x336366F1),
                  blurRadius: 8,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Iconsax.information,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
