// ignore_for_file: use_function_type_syntax_for_parameters

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:reservation_app/bloc/bloc.dart';
import 'package:reservation_app/core/services/reservations_service.dart';
import 'package:reservation_app/core/utils/helpers/network_info_helper.dart';
import 'package:reservation_app/model/reservation.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  ReservationsBloc() : super(InitialReservationsState()) {
    on((event, emit) async {
      emit(Loading());
      if (event is GetReservations) {
        bool isConnected = await NetworkInfo().isConnected();
        final response = await ReservationsService().fetchReservations(isConnected);

        List<Reservation>? reservations = response;
        if (!isConnected && (reservations == null || reservations.isEmpty)) {
          emit(ReservationsError(errorMessage: "Not connected to internet and no data found in local storage."));
        } else {
          emit(ReservationsListLoaded(reservations: reservations!));
        }
      }
    });
  }
}
