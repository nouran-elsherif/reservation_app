import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reservation_app/bloc/bloc.dart';
import 'package:reservation_app/core/presentation/widgets/snackbar_widget.dart';
import 'package:reservation_app/core/services/logger_service.dart';
import 'package:reservation_app/core/utils/constants/app_assets.dart';

import 'package:reservation_app/model/reservation.dart';
import 'package:reservation_app/presentation/widgets/tickets_list_widget.dart';

class ReservationsListWidget extends StatefulWidget {
  final bool isDarkMode;
  const ReservationsListWidget({super.key, this.isDarkMode = false});

  @override
  State<ReservationsListWidget> createState() => _ReservationsListWidgetState();
}

class _ReservationsListWidgetState extends State<ReservationsListWidget> {
  late Color primaryTextColor, secondaryTextColor, mainBackgroundColor, multipleReservationsListColor, listBorderColor;
  late TextStyle boldTextStyle, regularTextStyle;
  int expandedIndex = -1;
//   List<bool> isReservationExpanded = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   setState(() {
      //     reservationsBloc.state.reservations?.map((e) => isReservationExpanded.add(false));
      //   });
    });
    primaryTextColor = widget.isDarkMode ? Colors.white : Colors.black;
    secondaryTextColor = widget.isDarkMode ? const Color.fromRGBO(154, 154, 154, 1) : Colors.black;
    mainBackgroundColor = widget.isDarkMode ? Colors.black : Colors.white;
    multipleReservationsListColor =
        widget.isDarkMode ? const Color.fromRGBO(30, 30, 30, 1) : const Color.fromRGBO(238, 238, 238, 1);
    listBorderColor = widget.isDarkMode ? const Color.fromRGBO(76, 76, 76, 1) : const Color.fromRGBO(154, 154, 154, 1);
    boldTextStyle = const TextStyle(fontWeight: FontWeight.w700);
    regularTextStyle = const TextStyle(fontWeight: FontWeight.w400);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: reservationsBloc,
      child: _buildBody(),
    );
  }

  _buildBody() {
    return BlocListener<ReservationsBloc, ReservationsState>(
      listener: (context, state) {
        if (state.message != null && state.message!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar(state.message!));
        }
      },
      child: BlocBuilder<ReservationsBloc, ReservationsState>(
        builder: (context, state) {
          LoggerService.log("state $state");
          if (state is ReservationsListLoaded) {
            List<Reservation> reservations = state.reservations ?? [];
            int numOfReservations = reservations.length;
            // setState(() {
            //   reservations.map((e) => isReservationExpanded.add(false));
            // });
            print("res ${reservations.length}");

            return Container(
                decoration: BoxDecoration(color: widget.isDarkMode ? Colors.black : const Color.fromRGBO(250, 250, 250, 1)),
                child: reservations.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              reservations.first.stays.first.stayImages.first,
                              height: 200.h,
                              width: 1.sw,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  Text("Hotel Check-in", style: boldTextStyle.copyWith(fontSize: 24, color: primaryTextColor)),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(numOfReservations > 1 ? 'Multiple Reservations' : reservations.first.stays.first.name,
                                      style: regularTextStyle.copyWith(fontSize: 15, color: primaryTextColor)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                                padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                                child: _buildReservationsList(reservations)),
                            SizedBox(
                              height: 40.h,
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Text('No Tickets found',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: widget.isDarkMode ? Colors.white : Colors.black)),
                      ));
          }
          if (state is Error) return Text(state.message ?? '');

          return _buildLoading();
        },
      ),
    );
  }

  _buildLoading() {
    return Container(
      width: 1.sw,
      child: Column(children: [
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          width: 30.w,
          height: 30.w,
          child: CircularProgressIndicator(
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        )
      ]),
    );
  }

  _buildOneReservation(Reservation reservation) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 40.h,
      ),
      _buildStayData(reservation),
      SizedBox(
        height: 40.h,
      ),
      //location

      if (reservation.userTickets != null && reservation.userTickets!.isNotEmpty)
        TicketsListWidget(
          userTickets: reservation.userTickets!,
          isDarkMode: widget.isDarkMode,
        ),
      if (reservation.userTickets != null && reservation.userTickets!.isNotEmpty)
        SizedBox(
          height: 40.h,
        ),
      SvgPicture.asset(AppAssets.separator),
      _buildRoomsList(reservation.stays.first.rooms),
      _buildGallery(reservation.stays.first.stayImages),
      SizedBox(
        height: 40.h,
      ),
      _buildDataItem(title: "Amenities", value: reservation.stays.first.amenities)
    ]);
  }

  _buildReservationsList(List<Reservation> reservations) {
    return Column(
        children:
            reservations.map<Widget>((item) => _buildExpandableReservationListItem(item, reservations.indexOf(item))).toList());
  }

  _buildExpandableReservationListItem(Reservation reservation, int index) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 15.w, vertical: 15.h),
      color: multipleReservationsListColor,
      child: Column(
        children: [
          Column(
            children: [
              InkWell(
                  onTap: () => setState(() {
                        if (expandedIndex == index) {
                          expandedIndex = -1;
                        } else {
                          expandedIndex = index;
                        }
                      }),
                  child: Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: listBorderColor))),
                    child: Row(children: [
                      Icon(
                        expandedIndex == index ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: primaryTextColor,
                        size: 30.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(reservation.stays.first.name, style: boldTextStyle.copyWith(fontSize: 18, color: primaryTextColor))
                    ]),
                  )),
              if (expandedIndex == index) _buildOneReservation(reservation)
            ],
          )
        ],
      ),
    );
  }

  _buildStayData(Reservation reservation) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildDataItem(title: "From", value: reservation.startDate),
          _buildDataItem(title: "Till", value: reservation.endDate),
        ],
      ),
      SizedBox(
        height: 40.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildDataItem(title: "Stars", isStars: true, stars: reservation.stays.first.stars),
          _buildDataItem(title: "Room Count", value: reservation.stays.first.rooms.length.toString()),
        ],
      )
    ]);
  }

  _buildRoomsList(List<Room> rooms) {
    return Column(children: rooms.map<Widget>((item) => _buildRoomListItem(item, rooms.indexOf(item))).toList());
  }

  _buildRoomListItem(Room room, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40.h,
        ),
        Text('Room Reservation $index', style: boldTextStyle.copyWith(color: primaryTextColor, fontSize: 18)),
        SizedBox(
          height: 40.h,
        ),
        Text('Guest(s):', style: boldTextStyle.copyWith(color: primaryTextColor, fontSize: 18)),
        Column(
            children: room.guests
                .map<Widget>((guest) => Row(
                      children: [
                        if (guest.avatar.isNotEmpty)
                          Container(
                            width: 30.w,
                            height: 30.w,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(
                              guest.avatar,
                            ),
                          ),
                        const SizedBox(
                          width: 6.5,
                        ),
                        Text(
                          '${guest.firstName} ${guest.lastName}',
                          style: regularTextStyle.copyWith(color: secondaryTextColor, fontSize: 15),
                        ),
                      ],
                    ))
                .toList()),
        SizedBox(
          height: 40.h,
        ),
        _buildDataItem(title: "Room Type", value: room.roomTypeName),
        SizedBox(
          height: 40.h,
        ),
        Row(
          children: [
            _buildDataItem(title: "Room Number", value: room.roomNumber),
          ],
        ),
        SizedBox(
          height: 40.h,
        ),
        SvgPicture.asset(AppAssets.separator),
      ],
    );
  }

  _buildGallery(List<String> stayImages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40.h,
        ),
        Text('Gallery', style: boldTextStyle.copyWith(color: primaryTextColor, fontSize: 18)),
        SizedBox(
          height: 225.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemExtent: 235.w,
            itemCount: stayImages.length,
            itemBuilder: (context, index) {
              return Container(
                width: 150.w,
                height: 225.h,
                margin: EdgeInsets.only(right: 10.w),
                // clipBehavior: Clip.hardEdge,
                // decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.network(
                  stayImages[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        )
      ],
    );
  }

  _buildDataItem({required String title, String? value, bool isStars = false, int? stars}) {
    return Container(
      //   width: 0.39.sw,
      constraints: BoxConstraints(minWidth: 0.39.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: boldTextStyle.copyWith(fontSize: 18, color: primaryTextColor)),
          SizedBox(
            height: 6.h,
          ),
          isStars
              ? FivePointedStar(
                  count: stars!,
                  color: const Color.fromRGBO(212, 179, 99, 1),
                  size: Size(18.w, 18.w),
                  //   selectedColor: const Color.fromRGBO(212, 179, 99, 1),
                )
              : Text(value ?? "", style: regularTextStyle.copyWith(fontSize: 15, color: secondaryTextColor))
        ],
      ),
    );
  }
}
