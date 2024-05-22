// ignore_for_file: avoid_print

import 'package:reservation_app/core/utils/constants/app_environment.dart';

class LoggerService {
  static log(Object? logMessage) {
    if (AppEnvironment.isProductionEnv()) {
      //   FirebaseCrashlytics.instance.log('$logMessage');
    } else {
      print(logMessage);
    }
  }
}
