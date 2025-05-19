// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StudentInformation _$StudentInformationFromJson(Map<String, dynamic> json) {
  return _StudentInformation.fromJson(json);
}

/// @nodoc
mixin _$StudentInformation {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  String get rank => throw _privateConstructorUsedError;
  int get starCount => throw _privateConstructorUsedError;
  String? get teacherUid => throw _privateConstructorUsedError;

  /// Serializes this StudentInformation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentInformationCopyWith<StudentInformation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentInformationCopyWith<$Res> {
  factory $StudentInformationCopyWith(
          StudentInformation value, $Res Function(StudentInformation) then) =
      _$StudentInformationCopyWithImpl<$Res, StudentInformation>;
  @useResult
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      int grade,
      String rank,
      int starCount,
      String? teacherUid});
}

/// @nodoc
class _$StudentInformationCopyWithImpl<$Res, $Val extends StudentInformation>
    implements $StudentInformationCopyWith<$Res> {
  _$StudentInformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? grade = null,
    Object? rank = null,
    Object? starCount = null,
    Object? teacherUid = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as int,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as String,
      starCount: null == starCount
          ? _value.starCount
          : starCount // ignore: cast_nullable_to_non_nullable
              as int,
      teacherUid: freezed == teacherUid
          ? _value.teacherUid
          : teacherUid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentInformationImplCopyWith<$Res>
    implements $StudentInformationCopyWith<$Res> {
  factory _$$StudentInformationImplCopyWith(_$StudentInformationImpl value,
          $Res Function(_$StudentInformationImpl) then) =
      __$$StudentInformationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      int grade,
      String rank,
      int starCount,
      String? teacherUid});
}

/// @nodoc
class __$$StudentInformationImplCopyWithImpl<$Res>
    extends _$StudentInformationCopyWithImpl<$Res, _$StudentInformationImpl>
    implements _$$StudentInformationImplCopyWith<$Res> {
  __$$StudentInformationImplCopyWithImpl(_$StudentInformationImpl _value,
      $Res Function(_$StudentInformationImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? grade = null,
    Object? rank = null,
    Object? starCount = null,
    Object? teacherUid = freezed,
  }) {
    return _then(_$StudentInformationImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as int,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as String,
      starCount: null == starCount
          ? _value.starCount
          : starCount // ignore: cast_nullable_to_non_nullable
              as int,
      teacherUid: freezed == teacherUid
          ? _value.teacherUid
          : teacherUid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentInformationImpl implements _StudentInformation {
  const _$StudentInformationImpl(
      {required this.uid,
      required this.name,
      required this.surname,
      required this.email,
      required this.grade,
      required this.rank,
      required this.starCount,
      this.teacherUid});

  factory _$StudentInformationImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentInformationImplFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String email;
  @override
  final int grade;
  @override
  final String rank;
  @override
  final int starCount;
  @override
  final String? teacherUid;

  @override
  String toString() {
    return 'StudentInformation(uid: $uid, name: $name, surname: $surname, email: $email, grade: $grade, rank: $rank, starCount: $starCount, teacherUid: $teacherUid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentInformationImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.starCount, starCount) ||
                other.starCount == starCount) &&
            (identical(other.teacherUid, teacherUid) ||
                other.teacherUid == teacherUid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, name, surname, email, grade,
      rank, starCount, teacherUid);

  /// Create a copy of StudentInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentInformationImplCopyWith<_$StudentInformationImpl> get copyWith =>
      __$$StudentInformationImplCopyWithImpl<_$StudentInformationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentInformationImplToJson(
      this,
    );
  }
}

abstract class _StudentInformation implements StudentInformation {
  const factory _StudentInformation(
      {required final String uid,
      required final String name,
      required final String surname,
      required final String email,
      required final int grade,
      required final String rank,
      required final int starCount,
      final String? teacherUid}) = _$StudentInformationImpl;

  factory _StudentInformation.fromJson(Map<String, dynamic> json) =
      _$StudentInformationImpl.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  String get surname;
  @override
  String get email;
  @override
  int get grade;
  @override
  String get rank;
  @override
  int get starCount;
  @override
  String? get teacherUid;

  /// Create a copy of StudentInformation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentInformationImplCopyWith<_$StudentInformationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
