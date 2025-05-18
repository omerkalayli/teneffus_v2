import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/failure.dart';
import 'package:teneffus/homeworks/domain/entities/homework.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final homeworksDataSourceProvider = Provider<HomeworksDataSource>(
    (ref) => HomeworksFirebaseDb(firestore: ref.watch(firestoreProvider)));

/// [HomeworksDataSource] implementation for Firebase.

abstract interface class HomeworksDataSource {
  Future<Either<Failure, List<Homework>>> getHomeworks({required String uid});
}

class HomeworksFirebaseDb implements HomeworksDataSource {
  final FirebaseFirestore firestore;
  final auth = FirebaseAuth.instance;
  HomeworksFirebaseDb({required this.firestore});

  @override
  Future<Either<Failure, List<Homework>>> getHomeworks(
      {required String uid}) async {
    try {
      final homeworks = await firestore
          .collection("users")
          .doc(uid)
          .collection("homeworks")
          .get();
      if (homeworks.docs.isEmpty) {
        return left(Failure("No homeworks found"));
      }
      final homeworkList = homeworks.docs
          .map((doc) => Homework(
                id: doc["id"],
                myScore: doc["myScore"],
                grade: doc["grade"],
                unit: doc["unit"],
                lesson: doc["lesson"],
                minScore: doc["minScore"],
                dueDate: (doc["dueDate"] as Timestamp).toDate(),
                isCompleted: doc["isCompleted"],
                teacher: doc["teacher"],
                teacherId: doc["teacherId"],
              ))
          .toList();
      return right(homeworkList);
    } catch (e) {
      return left(Failure("Error getting homeworks $e"));
    }
  }
}
