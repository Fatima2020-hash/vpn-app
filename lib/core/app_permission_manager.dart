import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionManager {
  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  static Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  static Future<bool> requestPermissionEnforced(Permission permission) async {
    bool granted = await requestPermission(permission);
    if (!granted) {
      await openAppSettings();
    }
    return granted;
  }

  static Future<void> openApplicationSettings() async {
    await openAppSettings();
  }

  static Future<Map<Permission, bool>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    return statuses.map(
      (permission, status) => MapEntry(permission, status.isGranted),
    );
  }

  static Future<bool> isPermissionPermanentlyDenied(
    Permission permission,
  ) async {
    final status = await permission.status;
    return status.isPermanentlyDenied;
  }
}
