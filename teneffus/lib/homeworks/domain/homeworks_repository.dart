import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/failure.dart';
import 'package:teneffus/homeworks/data/homeworks_firebase_db.dart';
import 'package:teneffus/homeworks/data/homeworks_repository_impl.dart';
import 'package:teneffus/homeworks/domain/entities/homework.dart';

final homeworksRepositoryProvider = Provider<HomeworksRepositoryImpl>((ref) {
  final homeworksDataSource = ref.watch(homeworksDataSourceProvider);
  return HomeworksRepositoryImpl(homeworksDataSource);
});

abstract interface class HomeworksRepository {
  Future<Either<Failure, List<Homework>>> getHomeworks({required String uid});
}
