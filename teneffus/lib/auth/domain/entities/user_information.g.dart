// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInformationImpl _$$UserInformationImplFromJson(
        Map<String, dynamic> json) =>
    _$UserInformationImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      grade: (json['grade'] as num).toInt(),
    );

Map<String, dynamic> _$$UserInformationImplToJson(
        _$UserInformationImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'grade': instance.grade,
    };
