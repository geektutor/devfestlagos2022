import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IAuth {
  User? get currentUser;
  Stream<User?> get authStateChanges;
  Future<User?> signInWithGoogle();
  Future<User?> signInWithApple();
  Future<User?> signInWithEmail();
  Future<void> signOut();
}

class AuthImpl implements IAuth {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInWithEmail() async {
    return null;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      return await _firebaseSignInGoogle(googleAuth);
    }

    throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
  }

  Future<User?> _firebaseSignInGoogle(GoogleSignInAuthentication auth) async {
    if (auth.idToken != null) {
      final userCredential = await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: auth.idToken, accessToken: auth.accessToken),
      );

      return userCredential.user;
    }
    throw FirebaseAuthException(
      code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
      message: 'Missing Google ID Token',
    );
  }

  @override
  Future<User?> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();

    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }

    await _firebaseAuth.signOut();
  }
}
