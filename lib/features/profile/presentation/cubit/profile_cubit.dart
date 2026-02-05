import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/profile/domain/usecases/get_user_usecase.dart';
import 'package:mindmapai/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:mindmapai/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserUseCase _getUserUseCase;
  final SignOutUseCase _signOutUseCase;

  ProfileCubit({
    required GetUserUseCase getUserUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _getUserUseCase = getUserUseCase,
        _signOutUseCase = signOutUseCase,
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

  Future<void> signOut() async {
    try {
      await _signOutUseCase();
      // Here you would typically navigate to the login screen
    } catch (e) {
      // Handle sign-out error if needed
    }
  }
}
