class CategoryProducts{
  bool? status;
 CategoryProductsData? element;
  CategoryProducts.fromjson(Map<String,dynamic>json){
    status=json['status'];
    element=json['data']!=null?CategoryProductsData.fromjson(json['data']):null;
  }
}
class CategoryProductsData{
  int?current_page;
  List<Product>?item=[];
  CategoryProductsData.fromjson(Map<String,dynamic>json){
    current_page=json['current_page'];
json['data'].forEach((elements){
  item!.add(Product.fromjson(elements));
});
  }
}

class Product {
  int? id;
  dynamic? price;
  dynamic?old_price;
  dynamic?discount;
  String? image;
  String?name;
  bool?  in_favorites;
  bool?in_cart;
  Product.fromjson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];
  }

}
