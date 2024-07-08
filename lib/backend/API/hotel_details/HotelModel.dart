class HotelModel {
  String? id;
  String? name;
  String? type;
  String? city;
  String? address;
  String? distance;
  List<dynamic>? photos;
  String? title;
  String? desc;
  List<dynamic>? rooms;
  num? cheapestPrice;
  bool? featured;
  num? v;

  HotelModel({
    this.id,
    this.name,
    this.type,
    this.city,
    this.address,
    this.distance,
    this.photos,
    this.title,
    this.desc,
    this.rooms,
    this.cheapestPrice,
    this.featured,
    this.v,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['_id'],
      name: json['name'],
      type: json['type'],
      city: json['city'],
      address: json['address'],
      distance: json['distance'],
      photos: json['photos'],
      title: json['title'],
      desc: json['desc'],
      rooms: json['rooms'],
      cheapestPrice: json['cheapestPrice'],
      featured: json['featured'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['city'] = city;
    map['address'] = address;
    map['distance'] = distance;
    map['photos'] = photos;
    map['title'] = title;
    map['desc'] = desc;
    map['rooms'] = rooms;
    map['cheapestPrice'] = cheapestPrice;
    map['featured'] = featured;
    map['__v'] = v;
    return map;
  }
}