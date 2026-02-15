abstract class AuthRemoteDataSource {
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInWithEmail(String email);
}
