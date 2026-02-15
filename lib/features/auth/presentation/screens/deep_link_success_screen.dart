import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';

class DeepLinkSuccessScreen extends StatefulWidget {
  const DeepLinkSuccessScreen({super.key});

  @override
  State<DeepLinkSuccessScreen> createState() => _DeepLinkSuccessScreenState();
}

class _DeepLinkSuccessScreenState extends State<DeepLinkSuccessScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    // Задержка перед переходом на следующий экран
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        // TODO: Здесь должна быть логика проверки, новый ли это пользователь.
        // Если новый -> '/profile-setup'
        // Если старый -> '/home'
        // Сейчас для демонстрации всегда переходим на настройку профиля.
        context.go('/profile-setup');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Анимированная иконка
            SizedBox(
              width: 112,
              height: 112,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Пульсирующие круги
                  Container()
                      .animate(onPlay: (controller) => controller.repeat())
                      .scaleXY(
                          begin: 1,
                          end: 1.8,
                          duration: 2000.ms,
                          curve: Curves.easeOut)
                      .fade(begin: 0.3, end: 0),
                  Container()
                      .animate(onPlay: (controller) => controller.repeat())
                      .scaleXY(
                          begin: 1,
                          end: 1.5,
                          duration: 2000.ms,
                          delay: 300.ms,
                          curve: Curves.easeOut)
                      .fade(begin: 0.4, end: 0),
                  
                  // Центральный круг с галочкой
                  CircleAvatar(
                    radius: 56,
                    backgroundColor: colors.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.check_rounded,
                      color: colors.primary,
                      size: 56,
                    )
                        .animate()
                        .scaleXY( // Исправлено с .scale на .scaleXY
                            duration: 600.ms,
                            delay: 300.ms,
                            curve: Curves.elasticOut)
                        .fade(delay: 300.ms),
                  ),
                ],
              ),
            )
                .animate()
                .fade(duration: 600.ms)
                .scaleXY(begin: 0.8, curve: Curves.easeOutBack), // ИСПРАВЛЕНО
            const Gap(32),

            // Текст
            Text(
              "You're signed in",
              style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ).animate().fade(delay: 500.ms).slideY(begin: 0.5),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Preparing your workspace',
                  style: textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Gap(4),
                // Анимированные точки
                for (int i = 0; i < 3; i++)
                  Text(
                    '.',
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .fade(
                          begin: 0.3,
                          duration: 1500.ms,
                          delay: (i * 200).ms,
                          curve: Curves.easeInOut),
              ],
            ).animate().fade(delay: 500.ms).slideY(begin: 0.5),
          ],
        ),
      ),
    );
  }
}
