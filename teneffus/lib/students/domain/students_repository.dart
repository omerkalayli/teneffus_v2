import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/failure.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/students/data/students_firebase_db.dart';
import 'package:teneffus/students/data/students_repository_impl.dart';

final studentsRepositoryProvider = Provider<StudentsRepositoryImpl>((ref) {
  final studentDataSource = ref.watch(studentsDataSourceProvider);
  return StudentsRepositoryImpl(studentDataSource);
});

abstract interface class StudentsRepository {
  Future<Either<Failure, void>> addStudent(
      StudentInformation student, String teacherEmail);
  Future<Either<Failure, void>> deleteStudent(String uid);
  Future<Either<Failure, List<StudentInformation>>> getStudents();
  Future<Either<Failure, void>> removeStudent(
      StudentInformation student, String teacherEmail);
  Future<Either<Failure, void>> updateStudentStats({
    required List<WordStat> stats,
  });
  Future<Either<Failure, List<WordStat>>> getStudentStats(String email);
}
