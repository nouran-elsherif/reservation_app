// ignore_for_file: must_be_immutable

import 'package:meta/meta.dart';
import 'package:reservation_app/model/reservation.dart';

@immutable
abstract class ReservationsState {
  final List<Reservation>? reservations;
  final String? message;
  const ReservationsState({this.reservations, this.message});
}

class InitialReservationsState extends ReservationsState {}

class Loading extends ReservationsState {}

class ReservationsListLoaded extends ReservationsState {
  const ReservationsListLoaded({required List<Reservation> reservations}) : super(reservations: reservations);
}

class ReservationsError extends ReservationsState {
  String? errorMessage;
  ReservationsError({this.errorMessage});
}
