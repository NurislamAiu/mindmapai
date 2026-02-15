import 'package:mindmapai/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // Здесь будет зависимость от DataSource, например:
  // final AuthRemoteDataSource remoteDataSource;
  // AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmail(String email) {
    // TODO: implement signInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
