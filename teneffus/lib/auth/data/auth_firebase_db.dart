import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/failure.dart';

final authFirebaseDataSourceProvider =
    Provider<AuthFirebaseDataSource>((ref) => AuthFirebaseDb());

abstract interface class AuthFirebaseDataSource {
  Future<Either<Failure, UserCredential>> signInWithGoogle();
}

class AuthFirebaseDb implements AuthFirebaseDataSource {
  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return left(Failure("Google sign in cancelled"));
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message.toString()));
    }
  }
}
