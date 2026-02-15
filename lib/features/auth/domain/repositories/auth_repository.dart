abstract class AuthRepository {
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInWithEmail(String email);
  Future<void> setupUserProfile({required String name, String? photoUrl});
}
