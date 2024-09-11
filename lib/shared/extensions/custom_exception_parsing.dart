import '../../core/errors/exception.dart';
import '../../core/observers/logger.dart';
import 'exception_parsing.dart';

extension CustomExceptionParsing on CustomException {
  String get errorMessage {
    Logger.info('CustomExceptionParsing errorMessage: $this');

    if (message != null && message!.isNotEmpty) {
      return message.toString();
    }

    if (this is NetworkException) {
      return 'Something went wrong with internet connection';
    } else if (this is ServerException) {
      if (code != null) {
        if (code is Exception) {
          return (code as Exception).message;
        }

        return code.toString();
      }
    } else if (code != null) {
      return code.toString();
    }

    return toString();
  }
}
