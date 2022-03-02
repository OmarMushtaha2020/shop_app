class Favorites{
  bool? status;
  String?message;
  Favorites.fromjson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}