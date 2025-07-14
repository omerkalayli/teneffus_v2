import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teneffus/auth/domain/entities/user_information.dart';

part 'student_information.freezed.dart';
part 'student_information.g.dart';

@freezed
class StudentInformation extends UserInformation with _$StudentInformation {
  const factory StudentInformation({
    required String uid,
    required String name,
    required String surname,
    required String email,
    required int grade,
    required String rank,
    required int starCount,
    required int avatarId,
    required int dayStreak,
    required DateTime lastLogin,
    String? teacherUid,
  }) = _StudentInformation;

  factory StudentInformation.fromJson(Map<String, dynamic> json) =>
      _$StudentInformationFromJson(json);
}
