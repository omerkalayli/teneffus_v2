// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserInformation _$UserInformationFromJson(Map<String, dynamic> json) {
  return _UserInformation.fromJson(json);
}

/// @nodoc
mixin _$UserInformation {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;

  /// Serializes this UserInformation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInformationCopyWith<UserInformation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInformationCopyWith<$Res> {
  factory $UserInformationCopyWith(
          UserInformation value, $Res Function(UserInformation) then) =
      _$UserInformationCopyWithImpl<$Res, UserInformation>;
  @useResult
  $Res call({String uid, String name, String surname, String email, int grade});
}

/// @nodoc
class _$UserInformationCopyWithImpl<$Res, $Val extends UserInformation>
    implements $UserInformationCopyWith<$Res> {
  _$UserInformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? grade = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInformationImplCopyWith<$Res>
    implements $UserInformationCopyWith<$Res> {
  factory _$$UserInformationImplCopyWith(_$UserInformationImpl value,
          $Res Function(_$UserInformationImpl) then) =
      __$$UserInformationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, String name, String surname, String email, int grade});
}

/// @nodoc
class __$$UserInformationImplCopyWithImpl<$Res>
    extends _$UserInformationCopyWithImpl<$Res, _$UserInformationImpl>
    implements _$$UserInformationImplCopyWith<$Res> {
  __$$UserInformationImplCopyWithImpl(
      _$UserInformationImpl _value, $Res Function(_$UserInformationImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? grade = null,
  }) {
    return _then(_$UserInformationImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInformationImpl implements _UserInformation {
  const _$UserInformationImpl(
      {required this.uid,
      required this.name,
      required this.surname,
      required this.email,
      required this.grade});

  factory _$UserInformationImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInformationImplFromJson(json);

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
  String toString() {
    return 'UserInformation(uid: $uid, name: $name, surname: $surname, email: $email, grade: $grade)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInformationImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.grade, grade) || other.grade == grade));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, name, surname, email, grade);

  /// Create a copy of UserInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInformationImplCopyWith<_$UserInformationImpl> get copyWith =>
      __$$UserInformationImplCopyWithImpl<_$UserInformationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInformationImplToJson(
      this,
    );
  }
}

abstract class _UserInformation implements UserInformation {
  const factory _UserInformation(
      {required final String uid,
      required final String name,
      required final String surname,
      required final String email,
      required final int grade}) = _$UserInformationImpl;

  factory _UserInformation.fromJson(Map<String, dynamic> json) =
      _$UserInformationImpl.fromJson;

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

  /// Create a copy of UserInformation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInformationImplCopyWith<_$UserInformationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
