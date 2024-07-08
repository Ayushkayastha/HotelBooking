class LoginModel {
  LoginModel({
      this.details, 
      this.isAdmin,});

  LoginModel.fromJson(dynamic json) {
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
    isAdmin = json['isAdmin'];
  }
  Details? details;
  bool? isAdmin;
LoginModel copyWith({  Details? details,
  bool? isAdmin,
}) => LoginModel(  details: details ?? this.details,
  isAdmin: isAdmin ?? this.isAdmin,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (details != null) {
      map['details'] = details?.toJson();
    }
    map['isAdmin'] = isAdmin;
    return map;
  }

}

class Details {
  Details({
      this.id, 
      this.username, 
      this.email, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Details.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;
  num? v;
Details copyWith({  String? id,
  String? username,
  String? email,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Details(  id: id ?? this.id,
  username: username ?? this.username,
  email: email ?? this.email,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}