class AuthService {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // User? get currentUser => _firebaseAuth.currentUser;
  // Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  // Future<User?> loginWithEmail(String email, String password) async {
  //   final credential = await _firebaseAuth.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  //   return credential.user;
  // }

  // Future<User?> signUpWithEmail(String email, String password) async {
  //   final credential = await _firebaseAuth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  //   return credential.user;
  // }

  // Future<void> sendPasswordResetEmail(String email) {
  //   return _firebaseAuth.sendPasswordResetEmail(email: email);
  // }

  // Future<User?> loginWithGoogle() async {
  //   final gUser = await _googleSignIn.signIn();
  //   if (gUser == null) return null;
  //   final gAuth = await gUser.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: gAuth.accessToken,
  //     idToken: gAuth.idToken,
  //   );

  //   final userCred = await _firebaseAuth.signInWithCredential(credential);
  //   return userCred.user;
  // }

  // Future<User?> loginWithApple() async {
  //   final rawNonce = _generateNonce();
  //   final nonce = _sha256ofString(rawNonce);

  //   final appleCred = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //     nonce: nonce,
  //   );

  //   final oauth = OAuthProvider(
  //     "apple.com",
  //   ).credential(idToken: appleCred.identityToken, rawNonce: rawNonce);

  //   final userCred = await _firebaseAuth.signInWithCredential(oauth);
  //   return userCred.user;
  // }

  // Future<void> logout() async {
  //   await _firebaseAuth.signOut();
  //   try {
  //     await _googleSignIn.signOut();
  //   } catch (_) {}
  // }

  // String _generateNonce([int length = 32]) {
  //   const charset =
  //       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  //   final rand = Random.secure();
  //   return List.generate(
  //     length,
  //     (_) => charset[rand.nextInt(charset.length)],
  //   ).join();
  // }

  // String _sha256ofString(String input) {
  //   final bytes = utf8.encode(input);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }
}
