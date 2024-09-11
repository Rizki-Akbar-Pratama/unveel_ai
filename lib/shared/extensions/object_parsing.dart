import '../../core/errors/exception.dart';
import 'custom_exception_parsing.dart';
import 'exception_parsing.dart';

extension ObjectParsing on Object {
  String get message {
    if (this is Exception) {
      return (this as Exception).message;
    } else if (this is CustomException) {
      return (this as CustomException).errorMessage;
    }

    return toString();
  }
}
