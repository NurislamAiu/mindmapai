import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// The primary call-to-action card for a new user.
///
/// This widget is designed to be the focal point of the new user screen,
/// with a vibrant design and a clear, singular action.
class HomeEmptyState extends StatefulWidget {
  const HomeEmptyState({super.key});

  @override
  State<HomeEmptyState> createState() => _HomeEmptyStateState();
}

class _HomeEmptyStateState extends State<HomeEmptyState> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // TODO: Navigate to analyze screen
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.0),
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? const Color(0xFF6366F1).withOpacity(0.5)
                    : const Color(0xFF6366F1).withOpacity(0.3),
                blurRadius: _isHovered ? 20 : 12,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Column(
            children: [
              _buildIcon(),
              const SizedBox(height: 16),
              _buildTextContent(),
              const SizedBox(height: 24),
              _buildActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the central icon with a glassmorphism effect.
  Widget _buildIcon() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: const Icon(Iconsax.magic_star, color: Colors.white, size: 28),
    );
  }

  /// Builds the main title and subtitle with high-contrast white text.
  Widget _buildTextContent() {
    return Column(
      children: [
        Text(
          'Ready to Start Thinking?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Transform your ideas into structured insights with AI-powered analysis.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
        ),
      ],
    );
  }

  /// Builds the call-to-action button with a modern, clean style.
  Widget _buildActionButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF4F46E5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: const Text('Analyze Your First Idea'),
    );
  }
}
