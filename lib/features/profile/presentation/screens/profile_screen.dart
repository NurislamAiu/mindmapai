import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mindmapai/features/profile/domain/usecases/get_user_usecase.dart';
import 'package:mindmapai/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:mindmapai/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:mindmapai/features/profile/presentation/cubit/profile_state.dart';
import 'package:mindmapai/features/profile/presentation/widgets/profile_card.dart';
import 'package:mindmapai/features/profile/presentation/widgets/profile_header.dart';
import 'package:mindmapai/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:mindmapai/features/profile/presentation/widgets/profile_stats_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This is a simplified DI. In a real app, use get_it or provider.
    final profileRepository = ProfileRepositoryImpl();
    
    return BlocProvider(
      create: (context) => ProfileCubit(
        getUserUseCase: GetUserUseCase(profileRepository),
        signOutUseCase: SignOutUseCase(profileRepository),
      )..loadUserProfile(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFFF8F7F5),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F7F5),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            if (state is ProfileLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const ProfileHeader(),
                          const SizedBox(height: 24.0),
                          ProfileCard(user: state.user),
                          const SizedBox(height: 24.0),
                          ProfileMenuItem(
                            icon: Icons.star_border_rounded,
                            title: 'Upgrade to Pro',
                            subtitle: 'Unlock unlimited AI analyses',
                            onTap: () {},
                            isUpgrade: true,
                          ),
                          const SizedBox(height: 8.0),
                          ProfileMenuItem(
                            icon: Icons.settings_outlined,
                            title: 'Settings',
                            subtitle: 'App preferences and options',
                            onTap: () {},
                          ),
                          const SizedBox(height: 8.0),
                          ProfileMenuItem(
                            icon: Icons.help_outline_rounded,
                            title: 'Help & Support',
                            subtitle: 'Get help using MindMapAI',
                            onTap: () {},
                          ),
                          const SizedBox(height: 8.0),
                          ProfileMenuItem(
                            icon: Icons.logout_rounded,
                            title: 'Sign Out',
                            onTap: () => context.read<ProfileCubit>().signOut(),
                            isSignOut: true,
                          ),
                          const SizedBox(height: 24.0),
                          ProfileStatsCard(user: state.user),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
