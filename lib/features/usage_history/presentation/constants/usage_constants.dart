import 'package:flutter/material.dart';
import '../../domain/entities/usage_entry.dart';
import 'package:iconsax/iconsax.dart';

class UsageConstants {
  static const Map<ActionType, String> actionTypeLabels = {
    ActionType.initial: "Initial analysis",
    ActionType.refinement: "Refinement",
    ActionType.deep: "Deep analysis",
    ActionType.compare: "Compare",
  };

  static const Map<ActionType, IconData> actionTypeIcons = {
    ActionType.initial: Iconsax.lamp_on,
    ActionType.refinement: Iconsax.refresh,
    ActionType.deep: Iconsax.magic_star,
    ActionType.compare: Iconsax.arrow_swap,
  };
}
