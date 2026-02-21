import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/settings/domain/entities/user_profile.dart';

class ProfileSection extends StatelessWidget {
  final UserProfile userProfile;
  const ProfileSection({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    final bool isPro = userProfile.subscriptionStatus == SubscriptionStatus.pro;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: isPro
            ? LinearGradient(
                colors: [Colors.indigo.shade400, Colors.indigo.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isPro ? null : Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: isPro ? null : Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: isPro
                ? Colors.indigo.shade200.withOpacity(0.5)
                : Colors.grey.shade300.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPro ? Colors.white.withOpacity(0.1) : Colors.grey.shade100,
                  border: isPro
                      ? Border.all(color: Colors.white.withOpacity(0.2), width: 1.5)
                      : null,
                ),
                child: Center(
                  child: Text(
                    userProfile.name.substring(0, 1),
                    style: TextStyle(
                      color: isPro ? Colors.white : Colors.grey.shade800,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProfile.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isPro ? Colors.white : Colors.grey.shade900,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userProfile.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isPro
                                ? Colors.white.withOpacity(0.8)
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isPro
                      ? Colors.white.withOpacity(0.15)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    if (isPro)
                      Icon(Iconsax.crown_1, size: 14, color: Colors.yellow.shade600),
                    if (isPro) const SizedBox(width: 6),
                    Text(
                      isPro ? 'Pro' : 'Free',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isPro ? Colors.white : Colors.grey.shade800,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              context.push('/go-pro');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isPro ? Colors.white.withOpacity(0.9) : Colors.indigo.shade500,
              foregroundColor: isPro ? Colors.indigo.shade600 : Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Center(
              child: Text(
                isPro ? 'Manage Subscription' : 'Upgrade to Pro',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
