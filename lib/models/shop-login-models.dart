class ShopLoginModels {
  bool? status;
   dynamic message;

  UserData? data;

  ShopLoginModels.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromjson(json['data']) : null;
  }
}

class UserData {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic image;

  dynamic points;
  dynamic credit;
  dynamic toaken;

  UserData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    toaken = json['token'];
  }
}
