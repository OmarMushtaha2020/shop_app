class CategoriesModel {
  bool? status;
  CategoriesData? data;

  CategoriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesData.fromjson(json['data']);
  }
}

class CategoriesData {
  int? current_page;
  List<Data> data = [];

  CategoriesData.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(Data.fromjson(element));
    });
  }
}

class Data {
  int? id;
  String? name;
  String? image;

  Data.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
