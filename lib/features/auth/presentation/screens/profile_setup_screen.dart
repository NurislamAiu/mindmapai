import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  String? _photoUrl;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handlePhotoUpload() {
    // TODO: Implement photo upload logic (e.g., using image_picker)
    // For demo, we'll just set a placeholder
    setState(() {
      _photoUrl =
          'https://api.dicebear.com/7.x/initials/svg?seed=${_nameController.text.isNotEmpty ? _nameController.text : "User"}';
    });
  }

  void _handleContinue() {
    if (_nameController.text.trim().isNotEmpty) {
      // TODO: Save profile data
      // Navigate to the welcome screen
      // Using 'go' here to clear the auth navigation stack
      context.go('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Column(
                children: [
                  // Header
                  Text(
                    'Set up your workspace',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fade(delay: 100.ms).slideY(begin: 0.2),
                  const Gap(12),
                  Text(
                    'Help us personalize your experience with just a few details.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w300,
                    ),
                  ).animate().fade(delay: 100.ms).slideY(begin: 0.2),
                  const Gap(48),

                  // Profile Photo
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: colors.primary.withOpacity(0.1),
                            backgroundImage:
                                _photoUrl != null ? NetworkImage(_photoUrl!) : null,
                            child: _photoUrl == null
                                ? Icon(
                                    Icons.person,
                                    size: 48,
                                    color: colors.primary.withOpacity(0.4),
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ElevatedButton(
                              onPressed: _handlePhotoUpload,
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(8),
                                backgroundColor: Colors.white,
                                foregroundColor: colors.primary,
                                elevation: 2,
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              child: const Icon(Icons.camera_alt_outlined, size: 20),
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      const Text(
                        'Optional',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ).animate().fade(delay: 200.ms).slideY(begin: 0.2),
                  const Gap(32),

                  // Name Input
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: Text(
                          'Your name',
                          style: textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextField(
                        controller: _nameController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'e.g., Sarah Chen',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: colors.primary),
                          ),
                        ),
                        onChanged: (value) => setState(() {}),
                        onSubmitted: (_) => _handleContinue(),
                      ),
                    ],
                  ).animate().fade(delay: 300.ms).slideY(begin: 0.2),
                  const Gap(40),

                  // Continue Button
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _nameController,
                    builder: (context, value, child) {
                      return ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_forward, size: 20),
                        label: const Text('Continue'),
                        onPressed: value.text.trim().isNotEmpty ? _handleContinue : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF4F46E5),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                  ).animate().fade(delay: 400.ms).slideY(begin: 0.2),
                  const Gap(16),
                  const Text(
                    'You can change this later in Settings.',
                     style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                  ).animate().fade(delay: 500.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
