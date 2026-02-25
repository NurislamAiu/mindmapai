import 'package:flutter/material.dart';

class AiHintWidget extends StatelessWidget {
  const AiHintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo.shade50.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo.shade100.withOpacity(0.5)),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.indigo.shade100),
            ),
            child: const Icon(
              Icons.auto_awesome_outlined, // Sparkles
              color: Colors.indigo,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text(
                'AI will generate a structured analysis and visual mind map with key concepts, connections, and clear next steps',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF030213),
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
