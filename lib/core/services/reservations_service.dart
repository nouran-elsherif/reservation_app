import 'package:reservation_app/core/platform/reservations_channel.dart';
import 'package:reservation_app/core/services/logger_service.dart';
import 'package:reservation_app/model/reservation.dart';

class ReservationsService {
  Future<List<Reservation>?> fetchReservations() async {
    final List<Reservation>? reservations = await ReservationsMethodChannel().fetchReservations();
    LoggerService.log("==== ReservationsService fetchReservations $reservations");
    return reservations;
  }
}
