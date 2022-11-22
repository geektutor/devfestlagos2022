import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class IAuth {
  User? get currentUser;
  Stream<User?> get authStateChanges;
  Future<User?> signInWithGoogle();
  Future<User?> signInWithApple(
      {List<AppleIDAuthorizationScopes> scopes = const []});
  Future<User?> signInWithEmail();
  Future<void> signOut();
}

class AppleSignInAvailable {
  AppleSignInAvailable(this.isAvailable);
  final bool isAvailable;

  static Future<AppleSignInAvailable> check() async {
    return AppleSignInAvailable(await SignInWithApple.isAvailable());
  }
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
  Future<User?> signInWithApple(
      {List<AppleIDAuthorizationScopes> scopes = const []}) async {
    final result = await SignInWithApple.getAppleIDCredential(scopes: scopes);

    return await _firebaseAppleSignIn(result, scopes);

    // switch (result.status) {
    //   case AuthorizationStatus.authorized:
    //     return await _firebaseAppleSignIn(result, scopes);
    //
    //   case AuthorizationStatus.error:
    //     throw PlatformException(
    //       code: 'ERROR_AUTHORIZATION_DENIED',
    //       message: result.error.toString(),
    //     );
    //   case AuthorizationStatus.cancelled:
    //     throw PlatformException(
    //       code: 'ERROR_ABORTED_BY_USER',
    //       message: 'Sign in aborted by user',
    //     );
    //   default:
    //     throw UnimplementedError();
    // }
  }

  Future<User> _firebaseAppleSignIn(AuthorizationCredentialAppleID result,
      List<AppleIDAuthorizationScopes> scopes) async {
    final appleIdCredential = result;
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final firebaseUser = userCredential.user!;

    if (scopes.contains(AppleIDAuthorizationScopes.fullName)) {
      if (appleIdCredential.givenName != null &&
          appleIdCredential.familyName != null) {
        final displayName =
            '${appleIdCredential.givenName} ${appleIdCredential.familyName}';
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
