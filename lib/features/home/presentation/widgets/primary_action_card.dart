import 'package:flutter/material.dart';

class PrimaryActionCard extends StatelessWidget {
  const PrimaryActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        gradient: LinearGradient(
          colors: [Colors.indigo.shade600, Colors.purple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade200,
            blurRadius: 20.0,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Analyze a new idea',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Transform your thoughts into clarity',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Takes ~30 seconds',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white60),
              ),
              const Icon(Icons.arrow_forward, color: Colors.white70),
            ],
          )
        ],
      ),
    );
  }
}
