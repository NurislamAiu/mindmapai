import 'package:mindmapai/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getUser();
  Future<void> signOut();
}
