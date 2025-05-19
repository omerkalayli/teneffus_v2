// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeacherInformation _$TeacherInformationFromJson(Map<String, dynamic> json) {
  return _TeacherInformation.fromJson(json);
}

/// @nodoc
mixin _$TeacherInformation {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  List<StudentInformation> get students => throw _privateConstructorUsedError;

  /// Serializes this TeacherInformation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeacherInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeacherInformationCopyWith<TeacherInformation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeacherInformationCopyWith<$Res> {
  factory $TeacherInformationCopyWith(
          TeacherInformation value, $Res Function(TeacherInformation) then) =
      _$TeacherInformationCopyWithImpl<$Res, TeacherInformation>;
  @useResult
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      List<StudentInformation> students});
}

/// @nodoc
class _$TeacherInformationCopyWithImpl<$Res, $Val extends TeacherInformation>
    implements $TeacherInformationCopyWith<$Res> {
  _$TeacherInformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeacherInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? students = null,
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
      students: null == students
          ? _value.students
          : students // ignore: cast_nullable_to_non_nullable
              as List<StudentInformation>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeacherInformationImplCopyWith<$Res>
    implements $TeacherInformationCopyWith<$Res> {
  factory _$$TeacherInformationImplCopyWith(_$TeacherInformationImpl value,
          $Res Function(_$TeacherInformationImpl) then) =
      __$$TeacherInformationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      List<StudentInformation> students});
}

/// @nodoc
class __$$TeacherInformationImplCopyWithImpl<$Res>
    extends _$TeacherInformationCopyWithImpl<$Res, _$TeacherInformationImpl>
    implements _$$TeacherInformationImplCopyWith<$Res> {
  __$$TeacherInformationImplCopyWithImpl(_$TeacherInformationImpl _value,
      $Res Function(_$TeacherInformationImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeacherInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? students = null,
  }) {
    return _then(_$TeacherInformationImpl(
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
      students: null == students
          ? _value._students
          : students // ignore: cast_nullable_to_non_nullable
              as List<StudentInformation>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeacherInformationImpl implements _TeacherInformation {
  const _$TeacherInformationImpl(
      {required this.uid,
      required this.name,
      required this.surname,
      required this.email,
      required final List<StudentInformation> students})
      : _students = students;

  factory _$TeacherInformationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeacherInformationImplFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String email;
  final List<StudentInformation> _students;
  @override
  List<StudentInformation> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  @override
  String toString() {
    return 'TeacherInformation(uid: $uid, name: $name, surname: $surname, email: $email, students: $students)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeacherInformationImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._students, _students));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, name, surname, email,
      const DeepCollectionEquality().hash(_students));

  /// Create a copy of TeacherInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeacherInformationImplCopyWith<_$TeacherInformationImpl> get copyWith =>
      __$$TeacherInformationImplCopyWithImpl<_$TeacherInformationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeacherInformationImplToJson(
      this,
    );
  }
}

abstract class _TeacherInformation implements TeacherInformation {
  const factory _TeacherInformation(
          {required final String uid,
          required final String name,
          required final String surname,
          required final String email,
          required final List<StudentInformation> students}) =
      _$TeacherInformationImpl;

  factory _TeacherInformation.fromJson(Map<String, dynamic> json) =
      _$TeacherInformationImpl.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  String get surname;
  @override
  String get email;
  @override
  List<StudentInformation> get students;

  /// Create a copy of TeacherInformation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeacherInformationImplCopyWith<_$TeacherInformationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
