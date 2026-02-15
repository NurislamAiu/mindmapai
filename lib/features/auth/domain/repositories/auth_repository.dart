abstract class AuthRepository {
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInWithEmail(String email);
}
