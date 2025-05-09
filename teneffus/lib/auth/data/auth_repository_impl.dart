import 'package:fpdart/fpdart.dart';
import 'package:teneffus/auth/data/auth_firebase_db.dart';
import 'package:teneffus/auth/domain/auth_repository.dart';
import 'package:teneffus/auth/domain/entities/user_information.dart';
import 'package:teneffus/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource? authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, UserInformation>> signInWithGoogle() async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return await authDataSource!.signInWithGoogle();
    }
  }

  @override
  Future<Either<Failure, UserInformation>> signInWithEmail(
      {required String email, required String password}) async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return await authDataSource!
          .signInWithEmail(email: email, password: password);
    }
  }

  @override
  Future<Either<Failure, UserInformation>> registerUser({
    required String name,
    required String surname,
    required int grade,
    String? email,
    String? password,
  }) async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return await authDataSource!.registerUser(
        name: name,
        surname: surname,
        grade: grade,
        email: email,
        password: password,
      );
    }
  }

  @override
  Future<Either<Failure, UserInformation>> getUserInformation() async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return await authDataSource!.getUserInformation();
    }
  }

  @override
  Future<void> signOut() async {
    if (authDataSource != null) {
      await authDataSource!.signOut();
    }
  }

  @override
  Future<Either<Failure, bool>> sendResetPasswordEmail(
      {required String email}) async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return await authDataSource!.sendResetPasswordEmail(email: email);
    }
  }

  @override
  Future<void> increaseStarCount(
      {required String uid, required int starCount}) {
    if (authDataSource != null) {
      return authDataSource!.increaseStarCount(uid: uid, starCount: starCount);
    } else {
      throw Exception("Data source is null");
    }
  }
}
