// Models for parsing the JSON response

import 'package:reservation_app/model/ticket.dart';

class Reservation {
  final int id;
  final String startDate;
  final String endDate;
  final List<Stay> stays;
  final List<UserTicket>? userTickets;

  Reservation({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.stays,
    this.userTickets,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json['id'] as int,
        startDate: json['start_date'] as String,
        endDate: json['end_date'] as String,
        stays: List<Stay>.from(
          json['stays'].map((stay) => Stay.fromJson(stay)) as Iterable<dynamic>,
        ),
        userTickets: json['user_tickets'] != null
            ? List<UserTicket>.from(
                json['user_tickets'].map((ticket) => UserTicket.fromJson(ticket)) as Iterable<dynamic>,
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'start_date': startDate,
        'end_date': endDate,
        'stays': stays.map((stay) => stay.toJson()).toList(),
        'user_tickets': userTickets?.map((ticket) => ticket.toJson()).toList(),
      };
}

class Stay {
  final String name;
  final String description;
  final String lat;
  final String? lng;
  final String address;
  final String checkIn;
  final String checkOut;
  final int stars;
  final List<String> stayImages;
  final String amenities;
  final List<Room> rooms;

  Stay({
    required this.name,
    required this.description,
    required this.lat,
    this.lng,
    required this.address,
    required this.checkIn,
    required this.checkOut,
    required this.stars,
    required this.stayImages,
    required this.amenities,
    required this.rooms,
  });

  factory Stay.fromJson(Map<String, dynamic> json) => Stay(
        name: json['name'] as String,
        description: json['description'] as String,
        lat: json['lat'] as String,
        lng: json['lng'] as String?,
        address: json['address'] as String,
        checkIn: json['check_in'] as String,
        checkOut: json['check_out'] as String,
        stars: json['stars'] as int,
        stayImages: List<String>.from(json['stay_images'] as List<dynamic>),
        amenities: json['amenities'] as String,
        rooms: List<Room>.from(
          json['rooms'].map((room) => Room.fromJson(room)) as Iterable<dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'lat': lat,
        'lng': lng,
        'address': address,
        'check_in': checkIn,
        'check_out': checkOut,
        'stars': stars,
        'stay_images': stayImages,
        'amenities': amenities,
        'rooms': rooms.map((room) => room.toJson()).toList(),
      };
}

class Room {
  final String roomNumber;
  final int roomCapacity;
  final String roomTypeName;
  final String stayName;
  final List<Guest> guests;

  Room({
    required this.roomNumber,
    required this.roomCapacity,
    required this.roomTypeName,
    required this.stayName,
    required this.guests,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        roomNumber: json['room_number'] as String,
        roomCapacity: json['room_capacity'] as int,
        roomTypeName: json['room_type_name'] as String,
        stayName: json['stay_name'] as String,
        guests: List<Guest>.from(
          json['guests'].map((guest) => Guest.fromJson(guest)) as Iterable<dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
        'room_number': roomNumber,
        'room_capacity': roomCapacity,
        'room_type_name': roomTypeName,
        'stay_name': stayName,
        'guests': guests.map((guest) => guest.toJson()).toList(),
      };
}

class Guest {
  final String firstName;
  final String lastName;
  final String avatar;

  Guest({
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        avatar: json['avatar'] as String,
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'avatar': avatar,
      };
}
