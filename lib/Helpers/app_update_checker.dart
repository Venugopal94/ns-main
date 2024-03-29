import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUpdate {
  bool isForceUpdateRequired;
  bool shouldShowUpdateAlert;
  double updateVersion;

  AppUpdate(this.isForceUpdateRequired, this.shouldShowUpdateAlert, this.updateVersion);
}
class AppUpdateChecker {

  static final AppUpdateChecker instance =
  AppUpdateChecker._internal();

  AppUpdateChecker._internal();

  factory AppUpdateChecker() {
    return instance;
  }

  Future<AppUpdate> isAppNeedsUpdate() async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    //If it's QA build version can't to double due to Characters present in the version, to handle that setting current version
    // to 100000.0 to avoid force update alert.
    double currentVersion = double.tryParse(info.version.trim().replaceAll(".", "")) ?? 100000.0;

    //Get Latest version info from firebase config
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    // Firebase has increased the fetch interval duration to 12 hours, So won't get updated values for 12 hours even if change in firebase remote config.
    // So Overiding the default fetchConfig by setting custom, this will fetch the updated values everytime when user opens the app.
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 0),
      minimumFetchInterval: const Duration(minutes: 2),
    ));
    RemoteConfigValue(null, ValueSource.valueStatic);
    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch();
      await remoteConfig.fetchAndActivate();
      bool isForceUpdateOn = remoteConfig
          .getBool('force_update_required');
      double newVersion = Platform.isIOS ? double.parse(remoteConfig
          .getString('force_update_current_version_ios')
          .trim()
          .replaceAll(".", "")) : double.parse(remoteConfig
          .getString('force_update_current_version_android')
          .trim()
          .replaceAll(".", ""));
      //writeShouldShowPromotionalBanner(true);
      // Don't show update alert again if user skips the version.
      // If it's forceUpdate show the alert even if user skipped that version.
      final prefs = await SharedPreferences.getInstance();
      final userSkippedVersion = await prefs.getString("skipedVersion") ?? "10000.0";
      if (((newVersion > currentVersion) && isForceUpdateOn) || (newVersion > currentVersion && double.parse(userSkippedVersion ?? '') != newVersion)) {
        return AppUpdate(isForceUpdateOn, true, newVersion);
      } else {
        return AppUpdate(false, false, newVersion);
      }
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
      return AppUpdate(false, false, 0);
    }
  }
}