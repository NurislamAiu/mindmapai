import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SegmentedSetting<T extends Object> extends StatelessWidget {
  final String label;
  final IconData icon;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final Map<T, String> options;

  const SegmentedSetting({
    super.key,
    required this.label,
    required this.icon,
    required this.selectedValue,
    required this.onChanged,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey.shade900, size: 22),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl<T>(
              groupValue: selectedValue,
              onValueChanged: (value) {
                if (value != null) {
                  HapticFeedback.lightImpact();
                  onChanged(value);
                }
              },
              children: {
                for (var option in options.entries)
                  option.key: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(option.value),
                  ),
              },
              thumbColor: Colors.indigo.shade50,
              backgroundColor: Colors.grey.shade100,
            ),
          ),
        ],
      ),
    );
  }
}
