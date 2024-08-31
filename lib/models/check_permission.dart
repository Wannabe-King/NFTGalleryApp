import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  Future<bool> isStoragePermission() async {
    var isStorage = await Permission.manageExternalStorage.status;
    if (!isStorage.isGranted) {
      await Permission.manageExternalStorage.request();
      if (!isStorage.isGranted) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  Future<bool> isStoragePermissionLow() async {
    var isStorage = await Permission.storage.status;
    if (!isStorage.isGranted) {
      await Permission.storage.request();
      if (!isStorage.isGranted) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
