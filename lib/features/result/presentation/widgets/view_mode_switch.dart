import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/result_cubit.dart';
import '../cubit/result_state.dart';

class ViewModeSwitch extends StatelessWidget {
  final ViewMode currentMode;

  const ViewModeSwitch({
    super.key,
    required this.currentMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildModeButton(context, ViewMode.map, 'Map', Icons.map_outlined),
            _buildModeButton(context, ViewMode.business, 'Business', Icons.check_circle_outline),
            _buildModeButton(context, ViewMode.action, 'Action', Icons.auto_awesome),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(
    BuildContext context,
    ViewMode mode,
    String label,
    IconData icon,
  ) {
    final isSelected = mode == currentMode;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<ResultCubit>().switchMode(mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? const Color(0xFF030213) : const Color(0xFF717182),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  color: isSelected ? const Color(0xFF030213) : const Color(0xFF717182),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
