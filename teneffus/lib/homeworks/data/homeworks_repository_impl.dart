import 'package:fpdart/fpdart.dart';
import 'package:teneffus/failure.dart';
import 'package:teneffus/homeworks/data/homeworks_firebase_db.dart';
import 'package:teneffus/homeworks/domain/entities/homework.dart';
import 'package:teneffus/homeworks/domain/homeworks_repository.dart';

class HomeworksRepositoryImpl implements HomeworksRepository {
  final HomeworksDataSource? homeworksDataSource;

  HomeworksRepositoryImpl(this.homeworksDataSource);

  @override
  Future<Either<Failure, List<Homework>>> getHomeworks(
      {required String uid}) async {
    if (homeworksDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return homeworksDataSource!.getHomeworks(uid: uid);
    }
  }

  @override
  Future<Either<Failure, Null>> updateHomework(
      {required String uid,
      required int homeworkId,
      required int score,
      required bool isCompleted}) async {
    if (homeworksDataSource == null) {
      return left(Failure("Data source is null"));
    } else {
      return homeworksDataSource!.updateHomework(
          uid: uid,
          homeworkId: homeworkId,
          score: score,
          isCompleted: isCompleted);
    }
  }
}
