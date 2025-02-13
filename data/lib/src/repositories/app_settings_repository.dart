import 'package:package_info_plus/package_info_plus.dart';

class AppSettingsRepository {
  final PackageInfo packageInfo;

  AppSettingsRepository({required this.packageInfo});

  String getVersion() {
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
