import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/failure.dart';

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
}
