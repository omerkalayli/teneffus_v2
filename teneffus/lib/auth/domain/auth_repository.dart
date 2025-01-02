import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/data/auth_firebase_db.dart';
import 'package:teneffus/auth/data/auth_repository_impl.dart';
import 'package:teneffus/auth/domain/entities/user_information.dart';
import 'package:teneffus/failure.dart';

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(authDataSource);
});

abstract interface class AuthRepository {
  Future<Either<Failure, UserInformation>> signInWithGoogle();
  Future<Either<Failure, UserInformation>> signInWithEmail(
      {required String email, required String password});
  Future<Either<Failure, UserInformation>> registerUser({
    required String name,
    required String surname,
    required int grade,
    String? email,
    String? password,
  });
  Future<Either<Failure, UserInformation>> getUserInformation();
  Future<void> signOut();
  Future<Either<Failure, bool>> sendResetPasswordEmail({required String email});
}
