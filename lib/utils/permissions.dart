import 'package:permission_handler/permission_handler.dart';

requestPermissions() async {
  await Permission.camera.request();
}
