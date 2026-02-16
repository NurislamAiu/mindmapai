import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/help_support/domain/entities/contact_item.dart';

class ContactButton extends StatelessWidget {
  final ContactItem item;
  const ContactButton({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200.withOpacity(0.8),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (item.title == 'Contact Support') {
              context.push('/contact-support');
            } else if (item.title == 'Send Feedback') {
              context.push('/send-feedback');
            }
          },
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(item.icon),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(item.icon, color: _getIconColor(item.icon), size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1D2939),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade400, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(IconData icon) {
    if (icon == Iconsax.sms) return Colors.indigo.shade50;
    if (icon == Iconsax.message_edit) return Colors.purple.shade50;
    if (icon == Iconsax.warning_2) return Colors.amber.shade50;
    return Colors.grey.shade100;
  }

  Color _getIconColor(IconData icon) {
    if (icon == Iconsax.sms) return Colors.indigo.shade600;
    if (icon == Iconsax.message_edit) return Colors.purple.shade600;
    if (icon == Iconsax.warning_2) return Colors.amber.shade600;
    return Colors.grey.shade600;
  }
}
