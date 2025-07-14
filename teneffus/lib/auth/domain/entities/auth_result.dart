import 'package:teneffus/auth/domain/entities/user_information.dart';

class AuthResult {
  final UserInformation userInfo;
  final String userType;

  AuthResult({
    required this.userInfo,
    required this.userType,
  });
}
