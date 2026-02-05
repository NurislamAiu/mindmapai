import 'package:mindmapai/features/profile/domain/repositories/profile_repository.dart';

class SignOutUseCase {
  final ProfileRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}
