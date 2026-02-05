import 'package:mindmapai/features/profile/domain/entities/user_entity.dart';
import 'package:mindmapai/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<UserEntity> getUser() async {
    // Simulate a network request
    await Future.delayed(const Duration(milliseconds: 800));
    
    // This would typically come from an API or a local database
    return const UserEntity(
      id: '123',
      name: 'John Doe',
      email: 'john.doe@example.com',
      ideasAnalyzed: 3,
      daysActive: 7,
    );
  }

  @override
  Future<void> signOut() async {
    // Simulate a sign-out process
    await Future.delayed(const Duration(milliseconds: 300));
    print('User signed out');
  }
}
