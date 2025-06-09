import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/students/domain/students_repository.dart';
import 'package:teneffus/students/presentation/students_state.dart';

part 'students_notifier.g.dart';

final allStudentsProvider = StateProvider<List<StudentInformation>>((ref) {
  return [];
});

@Riverpod(keepAlive: true)
class StudentsNotifier extends _$StudentsNotifier {
  late final StudentsRepository _studentsRepository;

  @override
  Future<StudentsState> build() async {
    _studentsRepository = ref.read(studentsRepositoryProvider);
    return const StudentsState.initial();
  }

  Future<bool> addStudent(StudentInformation info, String teacherEmail) async {
    state = const AsyncValue.loading();
    final result = await _studentsRepository.addStudent(info, teacherEmail);
    bool isSuccess = false;
    state = result.fold(
        (failure) => AsyncValue.data(StudentsState.error(failure.message)),
        (students) {
      isSuccess = true;
      return const AsyncValue.data(StudentsState.success());
    });
    if (isSuccess) {
      await ref.read(authNotifierProvider.notifier).getStudentInformation();
    }
    return isSuccess;
  }

  Future<void> deleteStudent(String uid) async {
    state = const AsyncValue.loading();
    final result = await _studentsRepository.deleteStudent(uid);
    state = result.fold(
      (failure) => AsyncValue.data(StudentsState.error(failure.message)),
      (students) => const AsyncValue.data(StudentsState.success()),
    );
  }

  Future<void> getStudents() async {
    state = const AsyncValue.loading();
    final result = await _studentsRepository.getStudents();
    state = result.fold(
        (failure) => AsyncValue.data(StudentsState.error(failure.message)),
        (students) {
      ref.read(allStudentsProvider.notifier).state = students;
      return const AsyncValue.data(StudentsState.success());
    });
  }

  Future<void> removeStudent(
      StudentInformation student, String teacherEmail) async {
    state = const AsyncValue.loading();
    final result =
        await _studentsRepository.removeStudent(student, teacherEmail);
    state = result.fold(
      (failure) => AsyncValue.data(StudentsState.error(failure.message)),
      (students) {
        return const AsyncValue.data(StudentsState.success());
      },
    );
    if (result.isRight()) {
      await ref.read(studentsNotifierProvider.notifier).getStudents();
    }
  }

  Future<void> updateStudentStats({
    required List<WordStat> stats,
  }) async {
    await _studentsRepository.updateStudentStats(stats: stats);
  }

  Future<List<WordStat>?> getStudentStats(String email) async {
    final result = await _studentsRepository.getStudentStats(email);
    return result.fold(
      (failure) => null,
      (stats) => stats,
    );
  }
}
