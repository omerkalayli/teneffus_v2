import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/data/auth_firebase_db.dart';
import 'package:teneffus/auth/data/auth_repository_impl.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/auth/domain/entities/teacher_information.dart';
import 'package:teneffus/failure.dart';

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(authDataSource);
});

abstract interface class AuthRepository {
  Future<Either<Failure, AuthResult>> signInWithGoogle();
  Future<Either<Failure, AuthResult>> signInWithEmail({
    required String email,
    required String password,
  });
  Future<void> increaseStarCount({required String uid, required int starCount});
  Future<Either<Failure, StudentInformation>> registerStudent({
    required String name,
    required String surname,
    required int grade,
    String? email,
    String? password,
  });
  Future<Either<Failure, TeacherInformation>> registerTeacher({
    required String name,
    required String surname,
    String? email,
    String? password,
  });
  Future<Either<Failure, StudentInformation>> getStudentInformation();
  Future<Either<Failure, TeacherInformation>> getTeacherInformation();
  Future<void> signOut();
  Future<Either<Failure, bool>> sendResetPasswordEmail({required String email});
  Future<Either<Failure, String?>> getUserType({required String uid});
}
