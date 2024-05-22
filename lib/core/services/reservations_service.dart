import 'dart:convert';

import 'package:reservation_app/core/platform/reservations_channel.dart';
import 'package:reservation_app/core/services/logger_service.dart';
import 'package:reservation_app/core/services/shared_preferences_service.dart';
import 'package:reservation_app/model/reservation.dart';

class ReservationsService {
  Future<List<Reservation>?> fetchReservations(bool isConnectedToInternet) async {
    List<Reservation>? reservations;
    if (isConnectedToInternet) {
      reservations = await ReservationsMethodChannel().fetchReservations();
    } else {
      print("not connected");
      final localDataString = LocalStorageService.getReservations();
      if (localDataString == null) return null;
      final localData = jsonDecode(localDataString) as Map<String, dynamic>;
      print("shared data is $localData");
      if (localData['reservations'] != null) {
        var reservationsJson = localData['reservations'];
        reservations = [];
        for (var reservation in reservationsJson) {
          reservations.add(Reservation.fromJson(reservation));
        }
        return reservations;
      }
    }
    LoggerService.log("==== ReservationsService fetchReservations $reservations");
    return reservations;
  }
}
