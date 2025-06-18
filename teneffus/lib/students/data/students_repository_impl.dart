import 'package:fpdart/src/either.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/failure.dart';
import 'package:teneffus/global_entities/student_stat.dart';
import 'package:teneffus/global_entities/word_stat.dart';
import 'package:teneffus/students/data/students_firebase_db.dart';
import 'package:teneffus/students/domain/students_repository.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  final StudentsDataSource? studentsDataSource;

  StudentsRepositoryImpl(this.studentsDataSource);

  @override
  Future<Either<Failure, void>> addStudent(
      StudentInformation student, String teacherEmail) async {
    if (studentsDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return studentsDataSource!.addStudent(student, teacherEmail);
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String uid) async {
    if (studentsDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return studentsDataSource!.deleteStudent(uid);
    }
  }

  @override
  Future<Either<Failure, List<StudentInformation>>> getStudents() async {
    if (studentsDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return studentsDataSource!.getStudents();
    }
  }

  @override
  Future<Either<Failure, void>> removeStudent(
      StudentInformation student, String teacherEmail) async {
    if (studentsDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return studentsDataSource!.removeStudent(student, teacherEmail);
    }
  }

  @override
  Future<Either<Failure, void>> updateWordStats(
      {required List<WordStat> stats}) async {
    if (studentsDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return studentsDataSource!.updateWordStats(stats: stats);
    }
  }

  @override
  Future<Either<Failure, List<WordStat>>> getWordStats(String email) async {
    if (studentsDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return studentsDataSource!.getWordStats(email);
    }
  }

  @override
  Future<Either<Failure, void>> updateStudentStats(
      {required StudentStat stats}) async {
    if (studentsDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return studentsDataSource!.updateStudentStats(stats: stats);
    }
  }

  @override
  Future<Either<Failure, StudentStat>> getStudentStat(String email) async {
    if (studentsDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return studentsDataSource!.getStudentStat(email);
    }
  }
}
