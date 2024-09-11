import 'dart:io';

extension FileParsing on File? {
  String? fileName({
    bool? isHideExtension,
  }) {
    if (this == null || this?.path == null) {
      return null;
    }

    final path = this!.path.split('/');
    String? fileName;
    if (path.isNotEmpty) {
      fileName = path.last;
    }
    if (fileName == null) {
      return null;
    }

    if (isHideExtension == true) {
      final split = fileName.split('.');

      if (split.isNotEmpty) {
        return split.first;
      }
    }

    return fileName;
  }

  String get extension {
    if (this == null || this?.path == null) {
      return '';
    }

    return this!.path.split('.').last;
  }
}
