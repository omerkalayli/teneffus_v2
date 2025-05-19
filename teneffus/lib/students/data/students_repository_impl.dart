import 'package:fpdart/src/either.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/failure.dart';
import 'package:teneffus/students/data/students_firebase_db.dart';
import 'package:teneffus/students/domain/students_repository.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  final StudentsDataSource? studentsDataSource;

  StudentsRepositoryImpl(this.studentsDataSource);

  @override
  Future<Either<Failure, void>> addStudent(StudentInformation student) async {
    if (studentsDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return studentsDataSource!.addStudent(student);
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
}
