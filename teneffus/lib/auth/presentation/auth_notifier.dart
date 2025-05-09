import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teneffus/auth/auth_state.dart';
import 'package:teneffus/auth/domain/auth_repository.dart';
import 'package:teneffus/auth/domain/entities/user_information.dart';
import 'package:teneffus/failure.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _authRepository;
  UserInformation? userInformation;
  @override
  Future<AuthState> build() async {
    _authRepository = ref.read(authRepositoryProvider);
    userInformation = await getUserInformation();
    return const AuthState.initial();
  }

  Future<UserInformation?>? getUserInformation() async {
    state = const AsyncValue.data(AuthState.initialLoading());
    final result = await _authRepository.getUserInformation();
    return result.fold(
      (failure) => null,
      (userInfo) {
        userInformation = userInfo;
        return userInfo;
      },
    );
  }

  Future<void> increaseStarCount({required int starCount}) async {
    if (userInformation != null) {
      await _authRepository.increaseStarCount(
          uid: userInformation!.uid, starCount: starCount);
      userInformation = userInformation!.copyWith(
        starCount: userInformation!.starCount + starCount,
      );
    }
  }

  Future<Either<Failure, bool>> sendResetPasswordEmail(
      {required String email}) async {
    return await _authRepository.sendResetPasswordEmail(email: email);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    userInformation = null;
    state = const AsyncValue.data(AuthState.unauthenticated());
  }

  Future<void>? redirectToRegister() {
    state = const AsyncValue.data(AuthState.register());
    return null;
  }

  Future<void>? redirectToUnauthenticated() {
    state = const AsyncValue.data(AuthState.unauthenticated());
    return null;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.data(AuthState.loading());
    final result = await _authRepository.signInWithGoogle();
    state = result.fold(
      (failure) {
        if (failure.message == "user-not-found") {
          return const AsyncValue.data(AuthState.register());
        } else {
          return AsyncValue.data(AuthState.error(failure.message));
        }
      },
      (userInfo) {
        userInformation = userInfo;
        return const AsyncValue.data(AuthState.authenticated());
      },
    );
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    state = const AsyncValue.data(AuthState.loading());
    final result =
        await _authRepository.signInWithEmail(email: email, password: password);
    state = result.fold(
      (failure) {
        if (failure.message == "user-not-found") {
          return const AsyncValue.data(AuthState.register());
        } else {
          return AsyncValue.data(AuthState.error(failure.message));
        }
      },
      (userInfo) {
        userInformation = userInfo;
        return const AsyncValue.data(AuthState.authenticated());
      },
    );
  }

  Future<void> registerUser({
    required String name,
    required String surname,
    required int grade,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.data(AuthState.loading());
    final result = await _authRepository.registerUser(
      name: name,
      surname: surname,
      grade: grade,
      email: email,
      password: password,
    );
    state = result.fold(
      (failure) => AsyncValue.data(AuthState.error(failure.message)),
      (userInformation) {
        this.userInformation = userInformation;
        return const AsyncValue.data(AuthState.authenticated());
      },
    );
  }
}
