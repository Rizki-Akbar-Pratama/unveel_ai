import 'package:equatable/equatable.dart';

abstract class CustomException extends Equatable {
  final Object? code;
  final String? message;

  const CustomException({
    this.code,
    this.message,
  });

  @override
  List<Object?> get props => [
        code,
        message,
      ];
}

class NetworkException extends CustomException {
  const NetworkException({
    super.code,
    super.message,
  });
}

class ServerException extends CustomException {
  const ServerException({
    super.code,
    super.message,
  });
}

class AuthException extends CustomException {
  const AuthException({
    super.code,
    super.message,
  });
}

class PermissionException extends CustomException {
  const PermissionException({
    super.code,
    super.message,
  });
}
