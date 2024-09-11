extension StringParsing on String {
  String get currencyToEmoji {
    final String currencyFlag = this;
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    final int firstLetter = currencyFlag.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = currencyFlag.codeUnitAt(1) - 0x41 + 0x1F1E6;

    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  bool get isContainsLetter {
    return RegExp(r'[a-zA-Z]').hasMatch(this);
  }

  bool get isContainsNumber {
    return RegExp(r'[0-9]').hasMatch(this);
  }

  bool get isContainsUpperCase {
    return RegExp(r'[A-Z]').hasMatch(this);
  }

  bool get isContainsLowerCase {
    return RegExp(r'[a-z]').hasMatch(this);
  }

  bool isContainsSpecialCharacter({
    bool? isWithOutComma,
  }) {
    if (isWithOutComma == true) {
      return RegExp(r'[!@#$%^&*()?":{}+|<>/\\=\-]').hasMatch(this);
    }

    return RegExp(r'[!@#$%^&*(),.?":{}+|<>/\\=\-]').hasMatch(this);
  }

  bool get isOnlyNumber {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  String toCapitalize() {
    if (length < 2) return toUpperCase();

    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toCapitalizes() {
    if (length < 2) return toUpperCase();
    if (split(' ').length < 2) return toCapitalize();

    final List<String> values = split(' ');
    String result = "";

    for (String val in values) {
      if (val.length > 1) {
        result += "${val[0].toUpperCase()}${val.substring(1).toLowerCase()} ";
      } else {
        result += "$val ";
      }
    }

    return result;
  }

  int? get toInt {
    return int.tryParse(this);
  }

  bool isSame({
    required String? otherValue,
  }) {
    return toLowerCase() == otherValue?.toLowerCase();
  }

  double? get parseToDouble {
    try {
      // change , to . for parse double
      final String value = replaceAll(',', '.');

      return double.tryParse(value);
    } catch (_) {
      return null;
    }
  }

  String? get typeToTitle {
    if (isEmpty) return null;

    return replaceAll("_", " ");
  }
}
