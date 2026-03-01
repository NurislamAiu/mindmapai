import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/profile/domain/entities/user_entity.dart';
import 'package:mindmapai/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileCard extends StatelessWidget {
  final UserEntity user;

  const ProfileCard({super.key, required this.user});

  void _showEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);

    showCupertinoDialog(
      context: context,
      builder: (dialogContext) {
        return CupertinoAlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            children: [
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: nameController,
                placeholder: 'Name',
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: CupertinoColors.extraLightBackgroundGray,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: emailController,
                placeholder: 'Email',
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: CupertinoColors.extraLightBackgroundGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                final updatedUser = user.copyWith(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                );
                context.read<ProfileCubit>().updateUser(updatedUser);
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade100, Colors.purple.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Icon(
              Icons.person_rounded,
              size: 28,
              color: Colors.indigo.shade700,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showEditProfileDialog(context),
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.indigo.shade600,
              size: 20,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Colors.indigo.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
