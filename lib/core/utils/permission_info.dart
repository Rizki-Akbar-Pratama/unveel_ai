import 'package:permission_handler/permission_handler.dart';

import '../observers/logger.dart';

abstract class PermissionInfo {
  Future<bool> requestPermission({
    required Permission permission,
  });
}

class PermissionInfoImpl implements PermissionInfo {
  @override
  Future<bool> requestPermission({
    required Permission permission,
  }) async {
    try {
      Logger.info('requestPermission params: permission: $permission');

      PermissionStatus permissionStatus = await permission.status;
      Logger.success('requestPermission permissionStatus: $permissionStatus');

      if (!permissionStatus.isGranted) {
        permissionStatus = await permission.request();
        Logger.success('requestPermission permissionStatus: $permissionStatus');
      }

      return permissionStatus.isGranted;
    } catch (error) {
      Logger.error('requestPermission error: $error');

      rethrow;
    }
  }
}
