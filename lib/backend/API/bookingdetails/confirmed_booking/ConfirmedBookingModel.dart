class ConfirmedBookingModel {
  ConfirmedBookingModel({
      this.id, 
      this.hotel, 
      this.room, 
      this.user, 
      this.checkIn, 
      this.checkOut, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  ConfirmedBookingModel.fromJson(dynamic json) {
    id = json['_id'];
    hotel = json['hotel'];
    room = json['room'];
    user = json['user'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? hotel;
  dynamic room;
  String? user;
  String? checkIn;
  String? checkOut;
  String? status;
  String? createdAt;
  String? updatedAt;
  num? v;
ConfirmedBookingModel copyWith({  String? id,
  String? hotel,
  dynamic room,
  String? user,
  String? checkIn,
  String? checkOut,
  String? status,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => ConfirmedBookingModel(  id: id ?? this.id,
  hotel: hotel ?? this.hotel,
  room: room ?? this.room,
  user: user ?? this.user,
  checkIn: checkIn ?? this.checkIn,
  checkOut: checkOut ?? this.checkOut,
  status: status ?? this.status,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['hotel'] = hotel;
    map['room'] = room;
    map['user'] = user;
    map['check_in'] = checkIn;
    map['check_out'] = checkOut;
    map['status'] = status;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}