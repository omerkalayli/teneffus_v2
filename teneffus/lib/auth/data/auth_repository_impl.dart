import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/src/either.dart';
import 'package:teneffus/auth/data/auth_firebase_db.dart';
import 'package:teneffus/auth/domain/auth_repository.dart';
import 'package:teneffus/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource? authFirebaseDataSource;

  AuthRepositoryImpl(this.authFirebaseDataSource);

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    if (authFirebaseDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return await authFirebaseDataSource!.signInWithGoogle();
    }
  }
}
