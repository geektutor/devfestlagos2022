import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/scope.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

abstract class IAuth {
  User? get currentUser;
  Stream<User?> get authStateChanges;
  Future<User?> signInWithGoogle();
  Future<User?> signInWithApple({List<Scope> scopes = const []});
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
  Future<User?> signInWithApple({List<Scope> scopes = const []}) async {
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        return await _firebaseAppleSignIn(result, scopes);

      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );
      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }

  Future<User> _firebaseAppleSignIn(
      AuthorizationResult result, List<Scope> scopes) async {
    final appleIdCredential = result.credential!;
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: String.fromCharCodes(appleIdCredential.identityToken!),
      accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final firebaseUser = userCredential.user!;

    if (scopes.contains(Scope.fullName)) {
      final fullName = appleIdCredential.fullName;

      if (fullName != null &&
          fullName.givenName != null &&
          fullName.familyName != null) {
        final displayName = '${fullName.givenName} ${fullName.familyName}';
        await firebaseUser.updateDisplayName(displayName);
      }
    }
    return firebaseUser;
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
