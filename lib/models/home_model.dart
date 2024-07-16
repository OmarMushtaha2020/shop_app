class ShopHomeModel {
  bool? status;
  HomeDataModel? data;

  ShopHomeModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }
}

class HomeDataModel {
  List<Banners>? banners = [];
  List<Broducts>? Products = [];

  HomeDataModel.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((elements) {
      banners!.add(Banners.fromjson(elements));
    });
    json['products'].forEach((elements) {
      Products!.add(Broducts.fromjson(elements));
    });
  }
}

class Broducts {
  int? id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? image;
  String? description;
  String? name;
  bool? in_favorites;
  bool? in_cart;

  Broducts.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    description = json['description'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}

class Banners {
  int? id;
  String? image;

  Banners.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
