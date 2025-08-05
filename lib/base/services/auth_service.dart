import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> loginWithEmail(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<User?> signUpWithEmail(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  /// Login with Google
  // Future<User?> loginWithGoogle() async {
  //   final googleUser = await _googleSignIn.signIn();
  //   if (googleUser == null) return null;

  //   final googleAuth = await googleUser.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   final userCredential =
  //       await _firebaseAuth.signInWithCredential(credential);
  //   return userCredential.user;
  // }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    // await _googleSignIn.signOut();
  }

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
}
