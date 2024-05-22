import 'package:reservation_app/core/services/logger_service.dart';

class AuthHelper {
  static String? token;

  static setIdToken(t) {
    if (t == null) {
      token = null;
    } else {
      //   token = 'Bearer $t';
      token = t;
    }
    LoggerService.log('setJwtToken new token $token');
  }

  static String? geIdToken({bool isAuth = false}) {
    if (isAuth && token != null) {
      return token;
    }
    return null;
  }

  static bool isSucessStatusCode(statusCode) {
    return statusCode == 200 || statusCode == 201 || statusCode == 204;
  }
}
