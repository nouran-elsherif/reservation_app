import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservation_app/model/ticket.dart';
import 'package:reservation_app/presentation/widgets/ticket_painter.dart';

class TicketsListWidget extends StatefulWidget {
  final List<UserTicket> userTickets;
  final bool isDarkMode, addExtraHorizontalPadding;
  const TicketsListWidget(
      {super.key, required this.userTickets, this.isDarkMode = false, this.addExtraHorizontalPadding = false});

  @override
  State<TicketsListWidget> createState() => _TicketsListWidgetState();
}

class _TicketsListWidgetState extends State<TicketsListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Container(
        decoration: BoxDecoration(color: widget.isDarkMode ? Colors.black : const Color.fromRGBO(250, 250, 250, 1)),
        padding: EdgeInsetsDirectional.symmetric(horizontal: widget.addExtraHorizontalPadding ? 25.w : 0),
        child: widget.userTickets.isNotEmpty
            ? ListView(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), children: [
                Text("Tickets:",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700, color: widget.isDarkMode ? Colors.white : Colors.black)),
                SizedBox(
                  height: 10.h,
                ),
                _buildticketsList()
              ])
            : SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Text('No Tickets found',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700, color: widget.isDarkMode ? Colors.white : Colors.black)),
              ));
  }

  _buildticketsList() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.userTickets.map<Widget>((item) => _buildTicketListItem(item)).toList());
  }

  _buildTicketListItem(UserTicket userTicket) {
    Color valueColor = widget.isDarkMode ? const Color.fromRGBO(154, 154, 154, 1) : const Color.fromRGBO(76, 76, 76, 1);
    return CustomPaint(
        painter: TicketPainter(
          borderColor: widget.isDarkMode ? Colors.black : Colors.white,
          bgColor: widget.isDarkMode ? const Color.fromRGBO(45, 45, 45, 1) : const Color.fromRGBO(233, 233, 233, 1),
        ),
        child: Container(
          padding: const EdgeInsetsDirectional.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (userTicket.ticketUserData.avatar.isNotEmpty)
                    Container(
                      width: 34.w,
                      height: 34.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: widget.isDarkMode ? Colors.white : Colors.black),
                          shape: BoxShape.circle),
                      child: Image.network(
                        //   'https://image.tmdb.org/t/p/w500${reservation.posterPath!}',
                        userTicket.ticketUserData.avatar,
                      ),
                    ),
                  const SizedBox(
                    width: 6.5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userTicket.ticketUserData.firstName} ${userTicket.ticketUserData.lastName}',
                        style: TextStyle(
                            color: widget.isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        '#${userTicket.ticketId}',
                        style: TextStyle(color: valueColor, fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Ticket Type: ",
                      style: TextStyle(
                          color: widget.isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    TextSpan(
                      text: userTicket.ticketTypeName,
                      style: TextStyle(
                          color: widget.isDarkMode ? const Color.fromRGBO(154, 154, 154, 1) : const Color.fromRGBO(76, 76, 76, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Seat: ",
                      style: TextStyle(
                          color: widget.isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    TextSpan(
                      text: '${userTicket.ticketSystemId} / Seat ${userTicket.seat}',
                      style: TextStyle(
                          color: widget.isDarkMode ? const Color.fromRGBO(154, 154, 154, 1) : const Color.fromRGBO(76, 76, 76, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
