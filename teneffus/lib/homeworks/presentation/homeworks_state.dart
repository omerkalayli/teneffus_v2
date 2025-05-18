import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teneffus/homeworks/domain/entities/homework.dart';

part 'homeworks_state.freezed.dart';

@freezed
class HomeworksState with _$HomeworksState {
  const factory HomeworksState.initial() = _Initial;
  const factory HomeworksState.loading() = _Loading;
  const factory HomeworksState.success(List<Homework> homeworks) = _Success;
  const factory HomeworksState.error(String message) = _Error;
}
