extension ExceptionParsing on Exception {
  String get message {
    final String message = toString();

    if (message.contains('Exception: ')) {
      // remove 'Exception: '
      return message.replaceAll('Exception: ', '');
    } else if (message.contains('insufficient') && message.contains('funds')) {
      return 'Insufficient balance';
    }

    return message;
  }
}
