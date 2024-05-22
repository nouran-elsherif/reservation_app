import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:reservation_app/core/services/logger_service.dart';
import 'package:reservation_app/core/services/shared_preferences_service.dart';
import 'package:reservation_app/model/reservation.dart';

class ReservationsMethodChannel {
  static MethodChannel methodChannel = const MethodChannel('reservationsChannel');

  Future<List<Reservation>?> fetchReservations() async {
    try {
      final result = await methodChannel.invokeMethod('fetchReservations');
      if (result != null) {
        await LocalStorageService.saveReservations(value: result);
        final response = jsonDecode(result) as Map<String, dynamic>;
        if (response['reservations'] != null) {
          var reservations = response['reservations'];
          List<Reservation> reservationModels = [];
          for (var reservation in reservations) {
            reservationModels.add(Reservation.fromJson(reservation));
          }
          return reservationModels;
        }
      }
      return null;
    } on PlatformException catch (e) {
      LoggerService.log("Failed: ${e}");
    }
    return null;
  }
}
