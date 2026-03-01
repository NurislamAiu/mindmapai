import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/profile/domain/entities/user_entity.dart';
import 'package:mindmapai/features/profile/domain/usecases/get_user_usecase.dart';
import 'package:mindmapai/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:mindmapai/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:mindmapai/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserUseCase _getUserUseCase;
  final SignOutUseCase _signOutUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  ProfileCubit({
    required GetUserUseCase getUserUseCase,
    required SignOutUseCase signOutUseCase,
    required UpdateUserUseCase updateUserUseCase,
  })  : _getUserUseCase = getUserUseCase,
        _signOutUseCase = signOutUseCase,
        _updateUserUseCase = updateUserUseCase,
        super(ProfileInitial());

  Future<void> loadUserProfile() async {
    emit(ProfileLoading());
    try {
      final user = await _getUserUseCase();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(const ProfileError('Failed to load user profile.'));
    }
  }

  Future<void> updateUser(UserEntity updatedUser) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      // Optimistically update the UI
      emit(ProfileLoaded(updatedUser));
      
      try {
        await _updateUserUseCase(updatedUser);
      } catch (e) {
        // Rollback on error
        emit(ProfileLoaded(currentState.user));
        emit(const ProfileError('Failed to update profile.'));
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _signOutUseCase();
    } catch (e) {
      // Handle sign-out error if needed
    }
  }
}
