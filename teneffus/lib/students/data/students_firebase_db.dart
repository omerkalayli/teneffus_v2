import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/failure.dart';
import 'package:teneffus/global_entities/word.dart';
import 'package:teneffus/global_entities/word_stat.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final studentsDataSourceProvider = Provider<StudentsDataSource>(
    (ref) => StudentsFirebaseDb(firestore: ref.watch(firestoreProvider)));

abstract interface class StudentsDataSource {
  Future<Either<Failure, void>> addStudent(
      StudentInformation student, String teacherEmail);
  Future<Either<Failure, void>> deleteStudent(String uid);
  Future<Either<Failure, List<StudentInformation>>> getStudents();
  Future<Either<Failure, void>> removeStudent(
      StudentInformation student, String teacherEmail);
  Future<Either<Failure, void>> updateStudentStats(
      {required List<WordStat> stats});
  Future<Either<Failure, List<WordStat>>> getStudentStats(String email);
}

class StudentsFirebaseDb implements StudentsDataSource {
  final FirebaseFirestore firestore;
  final auth = FirebaseAuth.instance;
  StudentsFirebaseDb({required this.firestore});

  @override
  Future<Either<Failure, void>> addStudent(
      StudentInformation student, String teacherEmail) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return left(Failure("Giriş yapılmamış kullanıcı"));
      }

      final userQuery = await FirebaseFirestore.instance
          .collection("teachers")
          .where("email", isEqualTo: teacherEmail)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userDoc = userQuery.docs.first;
        final userUid = userDoc.id;
        final teacherDoc = userQuery.docs.first;
        final teacherUid = teacherDoc.id;
        await FirebaseFirestore.instance
            .collection("teachers")
            .doc(userUid)
            .update({
          "students": FieldValue.arrayUnion([student.toJson()]),
        });
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "teacherUid": teacherUid,
        });
      } else {
        return left(Failure("no-teacher"));
      }

      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String uid) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return left(Failure("Giriş yapılmamış kullanıcı"));
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .update({
        "students": FieldValue.arrayRemove([uid])
      });

      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudentInformation>>> getStudents() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("students")
          .get();

      final students = snapshot.docs.map((doc) {
        final data = doc.data();
        return StudentInformation.fromJson(data);
      }).toList();

      return right(students);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeStudent(
      StudentInformation student, String teacherEmail) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return left(Failure("Giriş yapılmamış kullanıcı"));
      }

      final userQuery = await FirebaseFirestore.instance
          .collection("teachers")
          .where("email", isEqualTo: teacherEmail)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userDoc = userQuery.docs.first;
        final userUid = userDoc.id;
        await FirebaseFirestore.instance
            .collection("teachers")
            .doc(userUid)
            .update({
          "students": FieldValue.arrayRemove([student.toJson()]),
        });
      } else {
        return throw (Exception("no-teacher"));
      }

      final studentDoc = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: student.email)
          .limit(1)
          .get();

      if (studentDoc.docs.isNotEmpty) {
        final docId = studentDoc.docs.first.id;
        await FirebaseFirestore.instance.collection("users").doc(docId).update({
          "teacherUid": null,
        });
      }
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateStudentStats({
    required List<WordStat> stats,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return left(Failure("Giriş yapılmamış kullanıcı"));
      }

      final statsCollection = FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .collection("stats");

      for (final stat in stats) {
        final statDocRef = statsCollection.doc(stat.word.id);
        final docSnapshot = await statDocRef.get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data() as Map<String, dynamic>;

          // Mevcut değerleri al
          final currentCorrect = data['correctCount'] ?? 0;
          final currentIncorrect = data['incorrectCount'] ?? 0;
          final currentPassed = data['passedCount'] ?? 0;

          // Yeni değerleri ekle
          await statDocRef.set({
            'word': stat.word.toJson(),
            'correctCount': currentCorrect + stat.correctCount,
            'incorrectCount': currentIncorrect + stat.incorrectCount,
            'passedCount': currentPassed + stat.passedCount,
          }, SetOptions(merge: true));
        } else {
          // Eğer yoksa direkt ekle
          await statDocRef.set(stat.toJson());
        }
      }

      return right(null);
    } catch (e) {
      return left(Failure("İstatistik güncellenirken hata oluştu: $e"));
    }
  }

  @override
  Future<Either<Failure, List<WordStat>>> getStudentStats(String email) async {
    try {
      final userQuery = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userDoc = userQuery.docs.first;
        final statsCollection = userDoc.reference.collection("stats");
        final statsSnapshot = await statsCollection.get();

        if (statsSnapshot.docs.isNotEmpty) {
          final statsList = statsSnapshot.docs
              .map((doc) => WordStat.fromJson(doc.data()))
              .toList();
          return right(statsList);
        } else {
          return left(Failure("No stats found for this student"));
        }
      } else {
        return left(Failure("Student not found"));
      }
    } catch (e) {
      return left(Failure("Error getting student stats: $e"));
    }
  }
}
