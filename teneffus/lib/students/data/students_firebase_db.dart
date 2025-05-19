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
  Future<Either<Failure, void>> addStudent(StudentInformation student);
  Future<Either<Failure, void>> deleteStudent(String uid);
  Future<Either<Failure, List<StudentInformation>>> getStudents();
}

class StudentsFirebaseDb implements StudentsDataSource {
  final FirebaseFirestore firestore;
  final auth = FirebaseAuth.instance;
  StudentsFirebaseDb({required this.firestore});

  @override
  Future<Either<Failure, void>> addStudent(StudentInformation student) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return left(Failure("Giriş yapılmamış kullanıcı"));
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .update({
        "students": FieldValue.arrayUnion([student.uid])
      });

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
      final snapshot =
          await FirebaseFirestore.instance.collection("users").get();

      final students = snapshot.docs.map((doc) {
        final data = doc.data();
        return StudentInformation.fromJson(data);
      }).toList();

      return right(students);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
