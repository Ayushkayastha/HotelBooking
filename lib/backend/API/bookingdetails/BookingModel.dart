class BookingModel {
  BookingModel({
      this.hotel, 
      this.room, 
      this.user, 
      this.checkIn, 
      this.checkOut, 
      this.status, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  BookingModel.fromJson(dynamic json) {
    hotel = json['hotel'];
    room = json['room'];
    user = json['user'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    status = json['status'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? hotel;
  String? room;
  String? user;
  String? checkIn;
  String? checkOut;
  String? status;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
BookingModel copyWith({  String? hotel,
  String? room,
  String? user,
  String? checkIn,
  String? checkOut,
  String? status,
  String? id,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => BookingModel(  hotel: hotel ?? this.hotel,
  room: room ?? this.room,
  user: user ?? this.user,
  checkIn: checkIn ?? this.checkIn,
  checkOut: checkOut ?? this.checkOut,
  status: status ?? this.status,
  id: id ?? this.id,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotel'] = hotel;
    map['room'] = room;
    map['user'] = user;
    map['check_in'] = checkIn;
    map['check_out'] = checkOut;
    map['status'] = status;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}