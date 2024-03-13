import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class PermessionHelper {
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

  void permessionPrinter() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
    ].request();

    log("statuses: $statuses");
  }
}
