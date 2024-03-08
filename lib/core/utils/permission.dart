import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> checkPermission() async {
  var status = await Permission.storage.status;

  if (status.isGranted) {
    log('Izin penyimpanan sudah diberikan.');
  } else {
    if (status.isDenied) {
      await Permission.storage.request();
    } else {
      openAppSettings();
    }
  }
  log('status: $status');
  return status;
}
