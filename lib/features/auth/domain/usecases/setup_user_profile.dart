import 'package:mindmapai/features/auth/domain/repositories/auth_repository.dart';

class SetupUserProfile {
  final AuthRepository repository;

  SetupUserProfile(this.repository);

  Future<void> call({required String name, String? photoUrl}) async {
    return await repository.setupUserProfile(name: name, photoUrl: photoUrl);
  }
}
