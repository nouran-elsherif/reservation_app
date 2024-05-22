import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? sharedPreferences;
  // ignore: constant_identifier_names
  static const RESERVATIONS_KEY = 'RESERVATIONS_KEY';
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future saveReservations({required String value}) async {
    return await sharedPreferences!.setString(RESERVATIONS_KEY, value);
  }

  static dynamic getReservations() {
    return sharedPreferences!.get(RESERVATIONS_KEY);
  }

  static Future<bool> removeReservations() async {
    return await sharedPreferences!.remove(RESERVATIONS_KEY);
  }
}
