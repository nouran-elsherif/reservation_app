// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

@immutable
abstract class ReservationsEvent {
  const ReservationsEvent();
}

class GetReservations extends ReservationsEvent {
  const GetReservations() : super();
}
