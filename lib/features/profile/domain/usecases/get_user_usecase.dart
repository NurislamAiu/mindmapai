import 'package:mindmapai/features/profile/domain/entities/user_entity.dart';
import 'package:mindmapai/features/profile/domain/repositories/profile_repository.dart';

class GetUserUseCase {
  final ProfileRepository repository;

  GetUserUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.getUser();
  }
}
