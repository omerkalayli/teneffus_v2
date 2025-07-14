import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teneffus/auth/auth_state.dart';
import 'package:teneffus/auth/domain/auth_repository.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/auth/domain/entities/teacher_information.dart';
import 'package:teneffus/failure.dart';
import 'package:teneffus/main.dart';

part 'auth_notifier.g.dart';

final userTypeProvider = StateProvider<bool>((ref) => true);

final teacherInformationProvider =
    StateProvider<TeacherInformation?>((ref) => null);

final studentInformationProvider =
    StateProvider<StudentInformation?>((ref) => null);

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _authRepository;
  StudentInformation? studentInformation;
  TeacherInformation? teacherInformation;

  bool _isSignedIn = false;
  @override
  Future<AuthState> build() async {
    _authRepository = ref.read(authRepositoryProvider);
    bool isStudent = ref.read(userTypeProvider);
    if (_isSignedIn) {
      if (isStudent) {
        studentInformation = await getStudentInformation();
        ref.read(studentInformationProvider.notifier).state =
            studentInformation;
      } else {
        teacherInformation = await getTeacherInformation();
        ref.read(teacherInformationProvider.notifier).state =
            teacherInformation;
      }
    }
    return const AuthState.initial();
  }

  Future<StudentInformation?> getStudentInformation() async {
    state = const AsyncValue.loading();
    final result = await _authRepository.getStudentInformation();

    return result.fold(
      (failure) {
        state = AsyncValue.data(AuthState.error(failure.message));
        return null;
      },
      (userInfo) {
        studentInformation = userInfo;
        ref.read(studentInformationProvider.notifier).state =
            studentInformation;
        state = AsyncValue.data(
            AuthState.authenticated(studentInformation: userInfo));
        return userInfo;
      },
    );
  }

  Future<TeacherInformation?> getTeacherInformation() async {
    state = const AsyncValue.loading();
    final result = await _authRepository.getTeacherInformation();

    return result.fold(
      (failure) {
        state = AsyncValue.data(AuthState.error(failure.message));
        return null;
      },
      (userInfo) {
        teacherInformation = userInfo;
        ref.read(teacherInformationProvider.notifier).state =
            teacherInformation;
        state = AsyncValue.data(
            AuthState.authenticated(teacherInformation: teacherInformation));
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

  Future<Either<Failure, void>> updateAvatar({required int avatarId}) async {
    await _authRepository.updateAvatar(avatarId: avatarId);
    await getStudentInformation();
    return const Right(null);
  }

  Future<Either<Failure, bool>> sendResetPasswordEmail(
      {required String email}) async {
    return await _authRepository.sendResetPasswordEmail(email: email);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    studentInformation = null;
    teacherInformation = null;
    ref.read(restartAppProvider)();
    _isSignedIn = false;
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
        } else if (failure.message == "Exception: wrong-user-type") {
          return const AsyncValue.data(AuthState.error("wrong-user-type"));
        } else {
          return AsyncValue.data(AuthState.error(failure.message));
        }
      },
      (authResult) {
        _isSignedIn = true;
        if (authResult.userType == "student") {
          ref.read(userTypeProvider.notifier).state = true;
          studentInformation = authResult.userInfo as StudentInformation?;
        } else {
          ref.read(userTypeProvider.notifier).state = false;
          teacherInformation = authResult.userInfo as TeacherInformation?;
        }
        return AsyncValue.data(AuthState.authenticated(
            studentInformation: studentInformation,
            teacherInformation: teacherInformation));
      },
    );
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.data(AuthState.loading());
    final result =
        await _authRepository.signInWithEmail(email: email, password: password);
    state = result.fold(
      (failure) {
        if (failure.message == "user-not-found") {
          return const AsyncValue.data(AuthState.register());
        } else if (failure.message == "Exception: wrong-user-type") {
          return const AsyncValue.data(AuthState.error("wrong-user-type"));
        } else {
          return AsyncValue.data(AuthState.error(failure.message));
        }
      },
      (authResult) {
        _isSignedIn = true;
        if (authResult.userType == "student") {
          ref.read(userTypeProvider.notifier).state = true;
          studentInformation = authResult.userInfo as StudentInformation?;
        } else {
          ref.read(userTypeProvider.notifier).state = false;
          teacherInformation = authResult.userInfo as TeacherInformation?;
        }
        return AsyncValue.data(AuthState.authenticated(
            studentInformation: studentInformation,
            teacherInformation: teacherInformation));
      },
    );
  }

  Future<void> registerStudent({
    required String name,
    required String surname,
    required int grade,
    required String email,
    required String password,
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
        _isSignedIn = true;
        studentInformation = userInformation;
        ref.read(userTypeProvider.notifier).state = true;
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
        _isSignedIn = true;
        teacherInformation = userInformation;
        ref.read(userTypeProvider.notifier).state = false;
        return const AsyncValue.data(AuthState.authenticated());
      },
    );
  }

  Future<String?> getUserType(String uid) async {
    final result = await _authRepository.getUserType(uid: uid);
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

  Future<void> updateDayStreak(int dayStreak) async {
    if (studentInformation != null) {
      await _authRepository.updateDayStreak(dayStreak: dayStreak);
      studentInformation = studentInformation!.copyWith(dayStreak: dayStreak);
      ref.read(studentInformationProvider.notifier).state = studentInformation;
    }
  }

  Future<void> updateLastLoginDate() async {
    if (studentInformation != null) {
      await _authRepository.updateLastLoginDate(uid: studentInformation!.uid);
      studentInformation = studentInformation!.copyWith(
        lastLogin: await NTP.now(),
      );
      ref.read(studentInformationProvider.notifier).state = studentInformation;
    }
  }
}
