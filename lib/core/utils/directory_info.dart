import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../observers/logger.dart';

abstract class DirectoryInfo {
  Future<Directory?> get externalStorageDirectory;
  Future<Directory?> get documentsDirectory;
  Future<File> createNewFileInDocumentsDirectory({
    required String fileName,
  });
}

class DirectoryInfoImpl implements DirectoryInfo {
  const DirectoryInfoImpl();

  @override
  Future<Directory?> get externalStorageDirectory async {
    return await getExternalStorageDirectory();
  }

  @override
  Future<Directory?> get documentsDirectory async {
    return await getApplicationDocumentsDirectory();
  }

  @override
  Future<File> createNewFileInDocumentsDirectory({
    required String fileName,
  }) async {
    try {
      final Directory? directory = await documentsDirectory;

      if (directory == null) {
        throw Exception('Failed to get documents directory');
      }

      final file = File('${directory.path}/$fileName');
      Logger.info('createNewFileInDocumentsDirectory file $file');

      return file;
    } catch (error) {
      Logger.error('createNewFileInDocumentsDirectory error $error');

      rethrow;
    }
  }
}
