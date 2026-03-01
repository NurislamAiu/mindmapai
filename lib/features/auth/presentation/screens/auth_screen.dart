import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapai/features/auth/presentation/widgets/apple_icon.dart';
import 'package:mindmapai/features/auth/presentation/widgets/google_icon.dart';
import 'package:mindmapai/features/auth/presentation/widgets/mind_map_logo.dart';
import 'package:mindmapai/features/auth/presentation/widgets/social_sign_in_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _continueWithEmail() {
    if (_emailController.text.isNotEmpty) {
      // Используем push вместо go, чтобы добавить экран в стек
      context.push('/check-email', extra: _emailController.text);
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
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const MindMapLogo()
                      .animate()
                      .fade(duration: 700.ms)
                      .scale(
                        duration: 700.ms,
                        curve: const FlippedCurve(Curves.easeOutBack),
                      ),
                  const Gap(32),
                  Text(
                    'Welcome to MINDRA',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      .animate()
                      .fade(delay: 150.ms, duration: 600.ms)
                      .slideY(begin: 0.2, duration: 600.ms),
                  const Gap(12),
                  Text(
                    'Sign in to save your ideas, track version history, and access your analyses from anywhere.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                      .animate()
                      .fade(delay: 150.ms, duration: 600.ms)
                      .slideY(begin: 0.2, duration: 600.ms),
                  const Gap(40),
                  SocialSignInButton(
                    text: 'Continue with Apple',
                    icon: const AppleIcon(
                      size: 22,

                    ),
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {},
                  )
                      .animate()
                      .fade(delay: 250.ms, duration: 600.ms)
                      .slideY(begin: 0.2, duration: 600.ms),
                  const Gap(12),
                  SocialSignInButton(
                    text: 'Continue with Google',
                    icon: const GoogleIcon(size: 22),
                    onPressed: () {},
                    borderColor: Colors.grey.shade300,
                  )
                      .animate()
                      .fade(delay: 250.ms, duration: 600.ms)
                      .slideY(begin: 0.2, duration: 600.ms),
                  const Gap(24),
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'or',
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                    ],
                  ).animate().fade(delay: 350.ms, duration: 600.ms),
                  const Gap(24),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
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
                  ).animate().fade(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2, duration: 600.ms),
                  const Gap(12),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _emailController,
                    builder: (context, value, child) {
                      return ElevatedButton.icon(
                        icon: const Icon(Icons.mail_outline, size: 20),
                        label: const Text('Continue with email'),
                        onPressed: value.text.isNotEmpty ? _continueWithEmail : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                           backgroundColor: const Color(0xFF4F46E5),
                           foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                  ).animate().fade(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2, duration: 600.ms),
                  const Gap(32),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(text: 'By continuing, you agree to our '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.underline,
                             color: Colors.grey.shade800,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () => context.push('/terms-of-service'),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.underline,
                             color: Colors.grey.shade800,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () => context.push('/privacy-policy'),
                        ),
                      ],
                    ),
                  ).animate().fade(delay: 500.ms, duration: 600.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
