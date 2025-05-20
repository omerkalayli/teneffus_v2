import 'package:fpdart/fpdart.dart';
import 'package:teneffus/auth/data/auth_firebase_db.dart';
import 'package:teneffus/auth/domain/auth_repository.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/auth/domain/entities/teacher_information.dart';
import 'package:teneffus/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource? authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, AuthResult>> signInWithGoogle() async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return await authDataSource!.signInWithGoogle();
    }
  }

  @override
  Future<Either<Failure, AuthResult>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return await authDataSource!
          .signInWithEmail(email: email, password: password);
    }
  }

  @override
  Future<Either<Failure, StudentInformation>> registerStudent({
    required String name,
    required String surname,
    required int grade,
    String? email,
    String? password,
  }) async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return await authDataSource!.registerStudent(
        name: name,
        surname: surname,
        grade: grade,
        email: email,
        password: password,
      );
    }
  }

  @override
  Future<Either<Failure, StudentInformation>> getStudentInformation() async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return await authDataSource!.getStudentInformation();
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

  @override
  Future<Either<Failure, TeacherInformation>> registerTeacher(
      {required String name,
      required String surname,
      String? email,
      String? password}) async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return authDataSource!.registerTeacher(
        name: name,
        surname: surname,
        email: email,
        password: password,
      );
    }
  }

  @override
  Future<Either<Failure, TeacherInformation>> getTeacherInformation() async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return authDataSource!.getTeacherInformation();
    }
  }

  @override
  Future<Either<Failure, String>> getUserType({required String uid}) async {
    if (authDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return authDataSource!.getUserType(uid: uid);
    }
  }
}
