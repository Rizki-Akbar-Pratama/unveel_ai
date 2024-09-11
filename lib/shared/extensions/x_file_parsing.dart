import 'package:image_picker/image_picker.dart';

enum XFileType {
  image,
  video,
  unknown,
}

extension FileParsing on XFile? {
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

  Future<int> get sizeInKb async {
    if (this == null) {
      return 0;
    }

    final bytes = await this!.readAsBytes();
    return bytes.length ~/ 1024;
  }

  XFileType get type {
    final extension = this?.extension.toLowerCase();
    if (extension == null) {
      return XFileType.unknown;
    }

    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return XFileType.image;
      case 'mp4':
      case 'mov':
        return XFileType.video;
    }

    return XFileType.unknown;
  }
}
