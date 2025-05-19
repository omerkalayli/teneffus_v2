// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeacherInformationImpl _$$TeacherInformationImplFromJson(
        Map<String, dynamic> json) =>
    _$TeacherInformationImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      students: (json['students'] as List<dynamic>)
          .map((e) => StudentInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TeacherInformationImplToJson(
        _$TeacherInformationImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'students': instance.students,
    };
