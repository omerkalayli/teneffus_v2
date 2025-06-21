// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentInformationImpl _$$StudentInformationImplFromJson(
        Map<String, dynamic> json) =>
    _$StudentInformationImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      grade: (json['grade'] as num).toInt(),
      rank: json['rank'] as String,
      starCount: (json['starCount'] as num).toInt(),
      avatarId: (json['avatarId'] as num).toInt(),
      teacherUid: json['teacherUid'] as String?,
    );

Map<String, dynamic> _$$StudentInformationImplToJson(
        _$StudentInformationImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'grade': instance.grade,
      'rank': instance.rank,
      'starCount': instance.starCount,
      'avatarId': instance.avatarId,
      'teacherUid': instance.teacherUid,
    };
