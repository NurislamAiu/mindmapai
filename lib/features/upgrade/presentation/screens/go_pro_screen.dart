import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/common/widgets/common_app_bar.dart';

class GoProScreen extends StatelessWidget {
  const GoProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: const CommonAppBar(title: 'MINDRA Pro'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ProCard(),
            const SizedBox(height: 32),
            const _FeatureList(),
            const SizedBox(height: 32),
            const _SubscriptionButton(),
            const SizedBox(height: 24),
            const _LegalLinks(),
          ],
        ),
      ),
    );
  }
}

class _ProCard extends StatelessWidget {
  const _ProCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade400, Colors.indigo.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade200.withOpacity(0.7),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/icon/icon.png',
            height: 80,
            width: 80,
            color: Colors.white,
          ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8)),
          const SizedBox(height: 16),
          Text(
            'Unlock Your Full Potential',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2),
          const SizedBox(height: 8),
          Text(
            'Go Pro to get unlimited AI analysis, priority support, and more.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  height: 1.5,
                  fontWeight: FontWeight.w300
                ),
          ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }
}

class _FeatureList extends StatelessWidget {
  const _FeatureList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 16.0),
          child: Text(
            "What's Included",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
          ),
        ),
        const _FeatureItem(
          icon: Iconsax.cpu_charge,
          title: 'Unlimited AI Analyses',
          description: 'Explore your ideas without limits.',
        ).animate().fadeIn(delay: 500.ms, duration: 500.ms).slideX(begin: -0.1),
        const _FeatureItem(
          icon: Iconsax.flash_1,
          title: 'Faster Response Times',
          description: 'Get your AI-powered insights quicker.',
        ).animate().fadeIn(delay: 600.ms, duration: 500.ms).slideX(begin: -0.1),
        const _FeatureItem(
          icon: Iconsax.message_question,
          title: 'Priority Support',
          description: 'Get help from our team first.',
        ).animate().fadeIn(delay: 700.ms, duration: 500.ms).slideX(begin: -0.1),
         const _FeatureItem(
          icon: Iconsax.star_1,
          title: 'Exclusive Features',
          description: 'Access to new Pro features as they are released.',
        ).animate().fadeIn(delay: 800.ms, duration: 500.ms).slideX(begin: -0.1),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.indigo.shade400, size: 24),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SubscriptionButton extends StatelessWidget {
  const _SubscriptionButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Handle subscription logic
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo.shade600,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        shadowColor: Colors.indigo.shade200,
      ),
      child: const Text(
        'Subscribe Now - \$9.99/month',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white
        ),
      ),
    ).animate().fadeIn(delay: 900.ms, duration: 600.ms).slideY(begin: 0.2);
  }
}

class _LegalLinks extends StatelessWidget {
  const _LegalLinks();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Terms of Service',
            style: TextStyle(
              color: Colors.grey.shade600,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w300,
              fontSize: 12
            ),
          ),
        ),
        Text('•', style: TextStyle(color: Colors.grey.shade500)),
        TextButton(
          onPressed: () {},
          child: Text(
            'Privacy Policy',
            style: TextStyle(
              color: Colors.grey.shade600,
              decoration: TextDecoration.underline,
               fontWeight: FontWeight.w300,
               fontSize: 12
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1000.ms, duration: 600.ms);
  }
}
