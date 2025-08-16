import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceService {
  static final DeviceService _instance = DeviceService._internal();
  factory DeviceService() => _instance;
  DeviceService._internal();

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Map<String, dynamic>> getDeviceFingerprint() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return {
        'platform': 'android',
        'model': info.model,
        'brand': info.brand,
        'product': info.product,
        'androidId': info.id,
        'versionSdk': info.version.sdkInt,
      };
    }
    if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return {
        'platform': 'ios',
        'model': info.utsname.machine,
        'systemVersion': info.systemVersion,
        'identifierForVendor': info.identifierForVendor,
      };
    }
    return {'platform': Platform.operatingSystem};
  }
}