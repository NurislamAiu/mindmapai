import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingToggle(
      {super.key, required this.icon, required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.indigo.shade600,
          ),
        ],
      ),
    );
  }
}
