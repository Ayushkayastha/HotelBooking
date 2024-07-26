class LoginModel {
  LoginModel({
      this.details, 
      this.token, 
      this.isAdmin,});

  LoginModel.fromJson(dynamic json) {
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
    token = json['token'];
    isAdmin = json['isAdmin'];
  }
  Details? details;
  String? token;
  bool? isAdmin;
LoginModel copyWith({  Details? details,
  String? token,
  bool? isAdmin,
}) => LoginModel(  details: details ?? this.details,
  token: token ?? this.token,
  isAdmin: isAdmin ?? this.isAdmin,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (details != null) {
      map['details'] = details?.toJson();
    }
    map['token'] = token;
    map['isAdmin'] = isAdmin;
    return map;
  }

}

class Details {
  Details({
      this.isHotel, 
      this.id, 
      this.username, 
      this.email, 
      this.country, 
      this.city, 
      this.phone, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Details.fromJson(dynamic json) {
    isHotel = json['isHotel'];
    id = json['_id'];
    username = json['username'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  bool? isHotel;
  String? id;
  String? username;
  String? email;
  String? country;
  String? city;
  String? phone;
  String? createdAt;
  String? updatedAt;
  num? v;
Details copyWith({  bool? isHotel,
  String? id,
  String? username,
  String? email,
  String? country,
  String? city,
  String? phone,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Details(  isHotel: isHotel ?? this.isHotel,
  id: id ?? this.id,
  username: username ?? this.username,
  email: email ?? this.email,
  country: country ?? this.country,
  city: city ?? this.city,
  phone: phone ?? this.phone,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isHotel'] = isHotel;
    map['_id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['country'] = country;
    map['city'] = city;
    map['phone'] = phone;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}