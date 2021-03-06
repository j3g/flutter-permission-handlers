import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:location_permissions/src/permission_enums.dart';

class LocationPermissions {
  static const MethodChannel _channel =
      MethodChannel('com.baseflow.flutter/location_permissions');

  /// Check current permission status.
  ///
  /// Returns a [Future] containing the current permission status for the supplied [LocationPermissionLevel].
  static Future<PermissionStatus> checkPermissionStatus(
      {LocationPermissionLevel level =
          LocationPermissionLevel.location}) async {
    final int status =
        await _channel.invokeMethod('checkPermissionStatus', level.index);

    return PermissionStatus.values[status];
  }

  /// Check current service status.
  ///
  /// Returns a [Future] containing the current service status for the supplied [LocationPermissionLevel].
  static Future<ServiceStatus> checkServiceStatus(
      {LocationPermissionLevel level =
          LocationPermissionLevel.location}) async {
    final int status =
        await _channel.invokeMethod('checkServiceStatus', level.index);

    return ServiceStatus.values[status];
  }

  /// Open the App settings page.
  ///
  /// Returns [true] if the app settings page could be opened, otherwise [false] is returned.
  static Future<bool> openAppSettings() async {
    final bool hasOpened = await _channel.invokeMethod('openAppSettings');

    return hasOpened;
  }

  /// Request the user for access to the location services.
  ///
  /// Returns a [Future<PermissionStatus>] containing the permission status.
  static Future<PermissionStatus> requestPermissions(
      {LocationPermissionLevel permissionLevel =
          LocationPermissionLevel.location}) async {
    final int status =
        await _channel.invokeMethod('requestPermission', permissionLevel.index);

    return PermissionStatus.values[status];
  }

  /// Request to see if you should show a rationale for requesting permission.
  ///
  /// This method is only implemented on Android, calling this on iOS always
  /// returns [false].
  Future<bool> shouldShowRequestPermissionRationale(
      {LocationPermissionLevel permissionLevel =
          LocationPermissionLevel.location}) async {
    if (!Platform.isAndroid) {
      return false;
    }

    final bool shouldShowRationale = await _channel.invokeMethod(
        'shouldShowRequestPermissionRationale', permissionLevel.index);

    return shouldShowRationale;
  }
}
