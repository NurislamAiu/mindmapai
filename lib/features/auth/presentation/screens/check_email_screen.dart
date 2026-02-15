import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CheckEmailScreen extends StatefulWidget {
  const CheckEmailScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  bool isResent = false;

  void _resendLink() {
    if (isResent) return;

    setState(() => isResent = true);
    // Сбрасываем состояние через 3 секунды, чтобы кнопку можно было нажать снова
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => isResent = false);
      }
    });
  }

  void _changeEmail() {
    // Возвращаемся на предыдущий экран (AuthScreen)
    context.pop();
  }
  
  void _simulateDeepLinkSuccess() {
    // Симулируем успешный переход по ссылке
    // Используем 'go', чтобы очистить стек и нельзя было вернуться на экраны входа
    context.go('/deep-link-success');
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
                children: [
                  const Gap(32),

                  // Заголовки
                  Text(
                    'Check your email',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fade(delay: 150.ms).slideY(begin: 0.2),
                  const Gap(12),
                  Text(
                    'We\'ve sent a secure sign-in link to:',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w300,
                    ),
                  ).animate().fade(delay: 150.ms).slideY(begin: 0.2),
                  const Gap(16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      widget.email,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).animate().fade(delay: 150.ms).slideY(begin: 0.2),
                  const Gap(32),

                  // Инструкции
                  Text(
                    'Open the email and tap the link to continue.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w300,
                    ),
                  ).animate().fade(delay: 250.ms).slideY(begin: 0.2),
                   const Gap(8),
                  Text(
                    'The link will expire in 15 minutes.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ).animate().fade(delay: 250.ms).slideY(begin: 0.2),
                  const Gap(32),

                  // Основная кнопка
                  ElevatedButton.icon(
                    icon: const Icon(Icons.mail_outline, size: 20),
                    label: const Text('Open email app'),
                    onPressed: _simulateDeepLinkSuccess, // Обновлено
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: const Color(0xFF4F46E5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ).animate().fade(delay: 350.ms).slideY(begin: 0.2),
                  const Gap(24),

                  // Второстепенные действия
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _resendLink,
                        child: isResent
                          ? Row(
                              children: [
                                Icon(Icons.check, size: 16, color: colors.primary),
                                const Gap(4),
                                Text(
                                  'Link sent',
                                  style: TextStyle(color: colors.primary),
                                ),
                              ],
                            )
                          : const Text('Resend link'),
                      ),
                      const SizedBox(
                        height: 16,
                        child: VerticalDivider(width: 20),
                      ),
                       TextButton(
                        onPressed: _changeEmail,
                        child: const Text('Change email'),
                      ),
                    ],
                  ).animate().fade(delay: 450.ms),
                  const Gap(32),

                  // Текст-подсказка
                   Text(
                    "Didn't receive the email? Check your spam folder or make sure you entered the correct email address.",
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                       fontWeight: FontWeight.w300,
                    ),
                  ).animate().fade(delay: 550.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
