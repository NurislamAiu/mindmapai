import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpgradeActionButtons extends StatelessWidget {
  const UpgradeActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _GradientButton(
          onPressed: () { /* TODO: Handle get credits */ },
          text: 'Get credits',
        ),
        const SizedBox(height: 16),
        OutlinedButton(

          onPressed: () => context.push('/go-pro'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          child: const Text(
            'Go Pro (monthly credits)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const _GradientButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: LinearGradient(
          colors: [Colors.indigo.shade500, Colors.indigo.shade600],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade200.withOpacity(0.8),
            blurRadius: 18.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(24.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
