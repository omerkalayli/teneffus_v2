import 'package:freezed_annotation/freezed_annotation.dart';

part 'students_state.freezed.dart';

@freezed
class StudentsState with _$StudentsState {
  const factory StudentsState.initial() = _Initial;
  const factory StudentsState.loading() = _Loading;
  const factory StudentsState.error(String message) = _Error;
  const factory StudentsState.success() = _Success;
}
