class LoginModel {
  LoginModel({
      this.id, 
      this.username, 
      this.email, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  LoginModel.fromJson(dynamic json) {
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
LoginModel copyWith({  String? id,
  String? username,
  String? email,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => LoginModel(  id: id ?? this.id,
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