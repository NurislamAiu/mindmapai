import 'package:mindmapai/features/profile/domain/entities/user_entity.dart';
import 'package:mindmapai/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserUseCase {
  final ProfileRepository repository;

  UpdateUserUseCase(this.repository);

  Future<void> call(UserEntity user) async {
    return await repository.updateUser(user);
  }
}
