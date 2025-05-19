import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teneffus/auth/auth_state.dart';
import 'package:teneffus/auth/domain/auth_repository.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/auth/domain/entities/teacher_information.dart';
import 'package:teneffus/failure.dart';
import 'package:teneffus/main.dart';

part 'auth_notifier.g.dart';

final userTypeProvider = StateProvider<bool>((ref) => true);

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _authRepository;
  StudentInformation? studentInformation;
  TeacherInformation? teacherInformation;
  @override
  Future<AuthState> build() async {
    _authRepository = ref.read(authRepositoryProvider);
    bool isStudent = ref.read(userTypeProvider);
    if (isStudent) {
      studentInformation = await getStudentInformation();
    } else {
      teacherInformation = await getTeacherInformation();
    }
    return const AuthState.initial();
  }

  Future<StudentInformation?>? getStudentInformation() async {
    state = const AsyncValue.data(AuthState.initialLoading());
    final result = await _authRepository.getStudentInformation();
    return result.fold(
      (failure) => null,
      (userInfo) {
        studentInformation = userInfo;
        return userInfo;
      },
    );
  }

  Future<TeacherInformation?>? getTeacherInformation() async {
    state = const AsyncValue.data(AuthState.initialLoading());
    final result = await _authRepository.getTeacherInformation();
    return result.fold(
      (failure) => null,
      (userInfo) {
        teacherInformation = userInfo;
        return userInfo;
      },
    );
  }

  Future<void> increaseStarCount({required int starCount}) async {
    if (studentInformation != null) {
      await _authRepository.increaseStarCount(
          uid: studentInformation!.uid, starCount: starCount);
      studentInformation = studentInformation!.copyWith(
        starCount: studentInformation!.starCount + starCount,
      );
    }
  }

  Future<Either<Failure, bool>> sendResetPasswordEmail(
      {required String email}) async {
    return await _authRepository.sendResetPasswordEmail(email: email);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    studentInformation = null;
    ref.read(restartAppProvider)();
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

  Future<void> signInWithGoogle({required bool isStudent}) async {
    state = const AsyncValue.data(AuthState.loading());
    final result = await _authRepository.signInWithGoogle(isStudent: isStudent);
    state = result.fold(
      (failure) {
        if (failure.message == "user-not-found") {
          return const AsyncValue.data(AuthState.register());
        } else {
          return AsyncValue.data(AuthState.error(failure.message));
        }
      },
      (userInfo) {
        if (isStudent) {
          studentInformation = userInfo as StudentInformation?;
        } else {
          teacherInformation = userInfo as TeacherInformation?;
        }
        return const AsyncValue.data(AuthState.authenticated());
      },
    );
  }

  Future<void> signInWithEmail(
      {required String email,
      required String password,
      required bool isStudent}) async {
    state = const AsyncValue.data(AuthState.loading());
    final result = await _authRepository.signInWithEmail(
        email: email, password: password, isStudent: isStudent);
    state = result.fold(
      (failure) {
        if (failure.message == "user-not-found") {
          return const AsyncValue.data(AuthState.register());
        } else {
          return AsyncValue.data(AuthState.error(failure.message));
        }
      },
      (userInfo) {
        if (isStudent) {
          studentInformation = userInfo as StudentInformation?;
        } else {
          teacherInformation = userInfo as TeacherInformation?;
        }
        return const AsyncValue.data(AuthState.authenticated());
      },
    );
  }

  Future<void> registerStudent({
    required String name,
    required String surname,
    required int grade,
    required String email,
    required String password,
    required bool isStudent,
  }) async {
    state = const AsyncValue.data(AuthState.loading());
    final result = await _authRepository.registerStudent(
      name: name,
      surname: surname,
      grade: grade,
      email: email,
      password: password,
    );
    state = result.fold(
      (failure) => AsyncValue.data(AuthState.error(failure.message)),
      (userInformation) {
        studentInformation = userInformation;
        return const AsyncValue.data(AuthState.authenticated());
      },
    );
  }

  Future<void> registerTeacher({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.data(AuthState.loading());
    final result = await _authRepository.registerTeacher(
      name: name,
      surname: surname,
      email: email,
      password: password,
    );
    state = result.fold(
      (failure) => AsyncValue.data(AuthState.error(failure.message)),
      (userInformation) {
        teacherInformation = userInformation;
        return const AsyncValue.data(AuthState.authenticated());
      },
    );
  }

  Future<String?> getUserType(String uid) async {
    final result = await _authRepository.getUserType(uid);
    return result.fold(
      (failure) => null,
      (userType) {
        if (userType == "student") {
          ref.read(userTypeProvider.notifier).state = true;
          return "student";
        } else if (userType == "teacher") {
          ref.read(userTypeProvider.notifier).state = false;
          return "teacher";
        } else {
          return null;
        }
      },
    );
  }
}
