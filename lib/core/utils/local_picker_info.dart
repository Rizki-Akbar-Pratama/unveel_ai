import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../observers/logger.dart';

abstract class LocalPickerInfo {
  Future<XFile?> selectImage({
    required ImageSource imageSource,
  });
  Future<XFile?> selectVideo({
    required ImageSource imageSource,
  });
  Future<XFile> saveImage({
    required Uint8List uint8List,
  });
}

class LocalPickerInfoImpl implements LocalPickerInfo {
  final ImagePicker imagePicker;

  const LocalPickerInfoImpl({
    required this.imagePicker,
  });

  @override
  Future<XFile?> selectImage({
    required ImageSource imageSource,
  }) async {
    try {
      Logger.info('selectImage imageSource: $imageSource');

      final XFile? result = await imagePicker.pickImage(
        source: imageSource,
      );
      Logger.success('selectImage result: $result');

      return result;
    } catch (error) {
      Logger.error('selectImage error: $error');

      rethrow;
    }
  }

  @override
  Future<XFile?> selectVideo({
    required ImageSource imageSource,
  }) async {
    try {
      Logger.info('selectVideo imageSource: $imageSource');

      final XFile? result = await imagePicker.pickVideo(
        source: imageSource,
      );
      Logger.success('selectVideo result: $result');

      return result;
    } catch (error) {
      Logger.error('selectVideo error: $error');

      rethrow;
    }
  }

  @override
  Future<XFile> saveImage({
    required Uint8List uint8List,
  }) async {
    try {
      Logger.info('saveImage');

      final pathDirectory = await getTemporaryDirectory();

      final path =
          '${pathDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png';

      await File(path).writeAsBytes(uint8List);

      return XFile(path);
    } catch (error) {
      Logger.error('saveImage error: $error');

      rethrow;
    }
  }
}
