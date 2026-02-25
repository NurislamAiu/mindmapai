import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const SettingsGroup({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8F7F5),
              borderRadius: BorderRadius.circular(16.0),
               boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(8, 8),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  blurRadius: 15,
                  offset: const Offset(-8, -8),
                ),
              ],
            ),
            child: Column(
              children: List.generate(children.length, (index) {
                return Column(
                  children: [
                    children[index],
                    if (index < children.length - 1)
                      const Divider(height: 1, indent: 16, endIndent: 16),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
