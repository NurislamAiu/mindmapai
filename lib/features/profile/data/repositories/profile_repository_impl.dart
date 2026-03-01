import 'package:mindmapai/features/profile/domain/entities/user_entity.dart';
import 'package:mindmapai/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  // Simulating a local cache/database
  UserEntity? _cachedUser;

  @override
  Future<UserEntity> getUser() async {
    if (_cachedUser != null) return _cachedUser!;

    // Simulate a network request
    await Future.delayed(const Duration(milliseconds: 800));
    
    _cachedUser = const UserEntity(
      id: '123',
      name: 'Nurislam Ilyassov',
      email: 'nuris.dev@gmail.com',
      ideasAnalyzed: 3,
      daysActive: 7,
    );
    
    return _cachedUser!;
  }

  @override
  Future<void> signOut() async {
    // Simulate a sign-out process
    await Future.delayed(const Duration(milliseconds: 300));
    _cachedUser = null;
    print('User signed out');
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    // Simulate a network request
    await Future.delayed(const Duration(milliseconds: 800));
    _cachedUser = user;
    print('User updated: ${user.name}');
  }
}
