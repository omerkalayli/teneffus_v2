import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/data/auth_firebase_db.dart';
import 'package:teneffus/auth/data/auth_repository_impl.dart';
import 'package:teneffus/failure.dart';

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final authFirebaseDataSource = ref.watch(authFirebaseDataSourceProvider);
  return AuthRepositoryImpl(authFirebaseDataSource);
});

abstract interface class AuthRepository {
  Future<Either<Failure, UserCredential>> signInWithGoogle();
}
