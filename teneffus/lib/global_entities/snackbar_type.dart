import 'package:freezed_annotation/freezed_annotation.dart';

part 'snackbar_type.freezed.dart';

@freezed
class SnackbarType with _$SnackbarType {
  factory SnackbarType.success() = _Success;
  factory SnackbarType.error() = _Error;
  factory SnackbarType.info() = _Info;
}
