import 'package:dog_age_plus/base/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  // User? get currentUser => _authService.currentUser;

  // Future<User?> login(String email, String password) async {
  //   return await _authService.loginWithEmail(email, password);
  // }

  // Future<User?> signUp(String email, String password) async {
  //   return await _authService.signUpWithEmail(email, password);
  // }

  // // Future<User?> loginWithGoogle() async {
  // // return await _authService.loginWithGoogle();
  // // }

  // Future<void> logout() async {
  //   await _authService.logout();
  // }

  // Stream<User?> get authStateChanges => _authService.authStateChanges();
}
