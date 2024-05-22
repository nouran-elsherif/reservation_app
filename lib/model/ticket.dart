class UserTicket {
  final int ticketId;
  final String seat;
  final String ticketSystemId;
  final String ticketTypeName;
  final UserTicketData ticketUserData;

  UserTicket({
    required this.ticketId,
    required this.seat,
    required this.ticketSystemId,
    required this.ticketTypeName,
    required this.ticketUserData,
  });

  factory UserTicket.fromJson(Map<String, dynamic> json) => UserTicket(
        ticketId: json['ticket_id'] as int,
        seat: json['seat'] as String,
        ticketSystemId: json['ticket_system_id'] as String,
        ticketTypeName: json['ticket_type_name'] as String,
        ticketUserData: UserTicketData.fromJson(json['ticket_user_data']),
      );

  Map<String, dynamic> toJson() => {
        'ticket_id': ticketId,
        'seat': seat,
        'ticket_system_id': ticketSystemId,
        'ticket_type_name': ticketTypeName,
        'ticket_user_data': ticketUserData.toJson(),
      };
}

class UserTicketData {
  final String firstName;
  final String lastName;
  final String avatar;
  final bool isUser;

  UserTicketData({
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.isUser,
  });

  factory UserTicketData.fromJson(Map<String, dynamic> json) => UserTicketData(
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        avatar: json['avatar'] as String,
        isUser: json['is_user'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'avatar': avatar,
        'is_user': isUser,
      };
}
