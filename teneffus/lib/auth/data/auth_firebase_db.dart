import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/domain/entities/student_information.dart';
import 'package:teneffus/auth/domain/entities/teacher_information.dart';
import 'package:teneffus/auth/domain/entities/user_information.dart';
import 'package:teneffus/failure.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final authDataSourceProvider = Provider<AuthDataSource>(
    (ref) => AuthFirebaseDb(firestore: ref.watch(firestoreProvider)));

/// [AuthDataSource] implementation for Firebase.

abstract interface class AuthDataSource {
  Future<Either<Failure, UserInformation>> signInWithGoogle(
      {required bool isStudent});
  Future<Either<Failure, UserInformation>> signInWithEmail(
      {required String email,
      required String password,
      required bool isStudent});
  Future<Either<Failure, String?>> getUserType(String uid);
  Future<Either<Failure, StudentInformation>> getStudentInformation();
  Future<Either<Failure, TeacherInformation>> getTeacherInformation();
  Future<Either<Failure, StudentInformation>> registerStudent({
    required String name,
    required String surname,
    required int grade,
    String? email,
    String? password,
  });
  Future<Either<Failure, TeacherInformation>> registerTeacher({
    required String name,
    required String surname,
    String? email,
    String? password,
  });
  Future<void> increaseStarCount({required String uid, required int starCount});
  Future<void> signOut();
  Future<Either<Failure, bool>> sendResetPasswordEmail({required String email});
}

class AuthFirebaseDb implements AuthDataSource {
  final FirebaseFirestore firestore;
  final auth = FirebaseAuth.instance;
  AuthFirebaseDb({required this.firestore});

  Future<bool> doesUserExist(
      {required String uid, required bool isStudent}) async {
    try {
      final user = await firestore
          .collection(isStudent ? "users" : "teachers")
          .doc(uid)
          .get();
      if (!user.exists) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, StudentInformation>> getStudentInformation() async {
    try {
      if (auth.currentUser == null) {
        return left(Failure("User not found"));
      }
      final user =
          await firestore.collection("users").doc(auth.currentUser!.uid).get();
      if (!user.exists) {
        return left(Failure("User not found"));
      }
      return right(StudentInformation(
        uid: auth.currentUser!.uid,
        name: user.get("name"),
        surname: user.get("surname"),
        email: auth.currentUser!.email!,
        grade: user.get("grade"),
        rank: user.get("rank"),
        starCount: user.get("starCount"),
      ));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<StudentSubInformation> getStudentSubInformation(
      {required String uid}) async {
    try {
      final user = await firestore.collection("users").doc(uid).get();
      if (!user.exists) {
        throw Exception("User not found");
      }
      return StudentSubInformation(
        name: user.get("name"),
        surname: user.get("surname"),
        grade: user.get("grade"),
        rank: user.get("rank"),
        starCount: user.get("starCount"),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, TeacherInformation>> getTeacherInformation() async {
    try {
      if (auth.currentUser == null) {
        return left(Failure("User not found"));
      }
      final user = await firestore
          .collection("teachers")
          .doc(auth.currentUser!.uid)
          .get();
      if (!user.exists) {
        return left(Failure("User not found"));
      }
      return right(TeacherInformation(
        uid: auth.currentUser!.uid,
        name: user.get("name"),
        surname: user.get("surname"),
        email: auth.currentUser!.email!,
        students: user.get("students") != null
            ? List<StudentInformation>.from(user
                .get("students")
                .map((student) => StudentInformation.fromJson(student)))
            : [],
      ));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<TeacherSubInformation> getTeacherSubInformation(
      {required String uid}) async {
    try {
      final user = await firestore.collection("teachers").doc(uid).get();
      if (!user.exists) {
        throw Exception("User not found");
      }
      return TeacherSubInformation(
        name: user.get("name"),
        surname: user.get("surname"),
        students: user.get("students") != null
            ? List<StudentInformation>.from(user
                .get("students")
                .map((student) => StudentInformation.fromJson(student)))
            : [],
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, UserInformation>> signInWithGoogle(
      {required bool isStudent}) async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return left(Failure("Google sign in cancelled"));
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user == null) {
        return left(Failure("User not found"));
      }

      bool userExists = await doesUserExist(
          uid: userCredential.user!.uid, isStudent: isStudent);

      if (userExists) {
        if (isStudent) {
          StudentSubInformation userSubInformation =
              await getStudentSubInformation(uid: userCredential.user!.uid);
          StudentInformation userInformation = StudentInformation(
            uid: userCredential.user!.uid,
            name: userSubInformation.name,
            surname: userSubInformation.surname,
            email: userCredential.user!.email!,
            grade: userSubInformation.grade,
            rank: userSubInformation.rank,
            starCount: userSubInformation.starCount,
          );
          return right(userInformation);
        } else {
          TeacherSubInformation userSubInformation =
              await getTeacherSubInformation(uid: userCredential.user!.uid);
          TeacherInformation userInformation = TeacherInformation(
            uid: userCredential.user!.uid,
            name: userSubInformation.name,
            surname: userSubInformation.surname,
            email: userCredential.user!.email!,
            students: userSubInformation.students,
          );
          return right(userInformation);
        }
      } else {
        return left(Failure("user-not-found")); // To redirect to register page.
      }
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.code.toString()));
    }
  }

  @override
  Future<Either<Failure, UserInformation>> signInWithEmail(
      {required String email,
      required String password,
      required bool isStudent}) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user == null) {
        return left(Failure("user-not-found"));
      }
      if (isStudent) {
        StudentSubInformation userSubInformation =
            await getStudentSubInformation(uid: userCredential.user!.uid);
        StudentInformation userInformation = StudentInformation(
          uid: userCredential.user!.uid,
          name: userSubInformation.name,
          surname: userSubInformation.surname,
          email: userCredential.user!.email!,
          grade: userSubInformation.grade,
          rank: userSubInformation.rank,
          starCount: userSubInformation.starCount,
        );
        return right(userInformation);
      } else {
        TeacherSubInformation userSubInformation =
            await getTeacherSubInformation(uid: userCredential.user!.uid);
        TeacherInformation userInformation = TeacherInformation(
          uid: userCredential.user!.uid,
          name: userSubInformation.name,
          surname: userSubInformation.surname,
          email: userCredential.user!.email!,
          students: userSubInformation.students,
        );
        return right(userInformation);
      }
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.code.toString()));
    }
  }

  /// Registers not registered users (only email) and writes db [StudentInformation] of the user.
  @override
  Future<Either<Failure, StudentInformation>> registerStudent(
      {required String name,
      required String surname,
      required int grade,
      String? email,
      String? password}) async {
    try {
      if (auth.currentUser == null) {
        // Signing in with email and password.

        final userCredential = await auth.createUserWithEmailAndPassword(
            email: email!, password: password!);

        if (userCredential.user == null) {
          return left(Failure("User not found"));
        }

        final userInfo = StudentInformation(
          uid: userCredential.user!.uid,
          name: name,
          surname: surname,
          email: email,
          grade: grade,
          rank: "Çaylak 1",
          starCount: 0,
        );

        await firestore.collection("users").doc(userCredential.user!.uid).set({
          "name": name,
          "surname": surname,
          "grade": grade,
          "rank": "Çaylak 1",
          "starCount": 0,
        });
        return right(userInfo);
      } else {
        // Signing in with Google.

        if (auth.currentUser == null) {
          return left(Failure("User not found"));
        }

        final userInfo = StudentInformation(
          uid: auth.currentUser!.uid,
          name: name,
          surname: surname,
          email: auth.currentUser!.email!,
          grade: grade,
          rank: "Çaylak 1",
          starCount: 0,
        );

        await firestore.collection("users").doc(auth.currentUser!.uid).set({
          "name": name,
          "surname": surname,
          "grade": grade,
          "rank": "Çaylak 1",
          "starCount": 0,
        });
        return right(userInfo);
      }
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.code.toString()));
    }
  }

  @override
  Future<void> signOut() {
    return auth.signOut();
  }

  @override
  Future<Either<Failure, bool>> sendResetPasswordEmail(
      {required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return right(true);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.code.toString()));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<void> increaseStarCount(
      {required String uid, required int starCount}) {
    try {
      return firestore.collection("users").doc(uid).update({
        "starCount": FieldValue.increment(starCount),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, TeacherInformation>> registerTeacher(
      {required String name,
      required String surname,
      String? email,
      String? password}) async {
    try {
      if (auth.currentUser == null) {
        // Signing in with email and password.

        final userCredential = await auth.createUserWithEmailAndPassword(
            email: email!, password: password!);

        if (userCredential.user == null) {
          return left(Failure("User not found"));
        }

        final userInfo = TeacherInformation(
          uid: userCredential.user!.uid,
          name: name,
          surname: surname,
          email: email,
          students: [],
        );

        await firestore
            .collection("teachers")
            .doc(userCredential.user!.uid)
            .set({
          "name": name,
          "surname": surname,
          "students": [],
        });
        return right(userInfo);
      } else {
        // Signing in with Google.

        if (auth.currentUser == null) {
          return left(Failure("User not found"));
        }

        final userInfo = TeacherInformation(
          uid: auth.currentUser!.uid,
          name: name,
          surname: surname,
          email: auth.currentUser!.email!,
          students: [],
        );

        await firestore.collection("teachers").doc(auth.currentUser!.uid).set({
          "name": name,
          "surname": surname,
          "students": [],
        });
        return right(userInfo);
      }
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.code.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getUserType(String uid) async {
    final firestore = FirebaseFirestore.instance;

    try {
      final teacherDoc = await firestore.collection("teachers").doc(uid).get();
      if (teacherDoc.exists) return right("teacher");

      final userDoc = await firestore.collection("users").doc(uid).get();
      if (userDoc.exists) return right("student");

      return right(null); // Kullanıcı bulunamadı ama hata değil
    } catch (e) {
      return left(Failure("Firestore hatası: ${e.toString()}"));
    }
  }
}

class StudentSubInformation {
  final String name;
  final String surname;
  final int grade;
  final String rank;
  final int starCount;

  StudentSubInformation({
    required this.name,
    required this.surname,
    required this.grade,
    required this.rank,
    required this.starCount,
  });
}

class TeacherSubInformation {
  final String name;
  final String surname;
  final List<StudentInformation> students;

  TeacherSubInformation(
      {required this.name, required this.surname, required this.students});
}
