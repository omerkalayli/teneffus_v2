import 'package:teneffus/auth/domain/entities/student_information.dart';

class TeacherSubInformation {
  final String name;
  final String surname;
  final List<StudentInformation> students;

  TeacherSubInformation(
      {required this.name, required this.surname, required this.students});
}
