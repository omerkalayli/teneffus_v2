import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teneffus/auth/domain/entities/user_information.dart';

part 'teacher_information.freezed.dart';
part 'teacher_information.g.dart';

@freezed
class TeacherInformation extends UserInformation with _$TeacherInformation {
  const factory TeacherInformation({
    required String uid,
    required String name,
    required String surname,
    required String email,
  }) = _TeacherInformation;

  factory TeacherInformation.fromJson(Map<String, dynamic> json) =>
      _$TeacherInformationFromJson(json);
}
