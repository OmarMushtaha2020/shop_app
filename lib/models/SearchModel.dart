class SearchModel {
  bool? status;
  Data? data;


  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<Products>? pc;



  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      pc = <Products>[];
      json['data'].forEach((v) {
        pc!.add( Products.fromJson(v));
      });
    }

  }

}

class Products {
  int? id;
  dynamic? price;
  String? image;
  String? name;
  String? description;

  bool? inFavorites;
  bool? inCart;



  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    // images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}