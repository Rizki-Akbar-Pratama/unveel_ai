import 'dart:ui';

enum SupportLocale {
  en,
}

extension SupportLocaleExtension on SupportLocale {
  Locale get locale {
    switch (this) {
      case SupportLocale.en:
        return const Locale('en');
    }
  }

  String get language {
    switch (this) {
      case SupportLocale.en:
        return 'English';
    }
  }
}
