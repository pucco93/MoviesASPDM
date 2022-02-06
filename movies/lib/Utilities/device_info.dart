import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  Future<bool> isIPhoneNotch() async {
    const List<String> _iosMachinesWithBottomNotch = [
      'iPhone10,3',
      'iPhone10,6',
      'iPhone11,2',
      'iPhone11,4',
      'iPhone11,6',
      'iPhone11,8',
      'iPhone12,1',
      'iPhone12,3',
      'iPhone12,5',
      'iPhone13,1',
      'iPhone13,2',
      'iPhone13,3',
      'iPhone13,4',
      'iPhone14,4',
      'iPhone14,5',
      'iPhone14,2',
      'iPhone14,3',
      'iPhone X',
      'iPhone XR',
      'iPhone XS',
      'iPhone XS Max',
      'iPhone 11',
      'iPhone 11 Pro',
      'iPhone 11 Pro Max',
      'iPhone 12 mini',
      'iPhone 12',
      'iPhone 12 Pro',
      'iPhone 12 Pro Max',
      'iPhone 13 mini',
      'iPhone 13',
      'iPhone 13 Pro',
      'iPhone 13 Pro Max',
    ];
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    final bool bottomNotch =
        _iosMachinesWithBottomNotch.contains(iosInfo.name);
    return bottomNotch;
  }
}