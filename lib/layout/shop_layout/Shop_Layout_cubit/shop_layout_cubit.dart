import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/categories_products.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/get_favorites.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/shop-login-models.dart';
import 'package:shop_app/modules/cateogries_page/cateogries_page.dart';
import 'package:shop_app/modules/favorites_page/favorites_page.dart';
import 'package:shop_app/modules/products_page/products_page.dart';
import 'package:shop_app/modules/settings_page/settings_page.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLayoutCubit extends Cubit<ShopeLayoutStates> {
  ShopLayoutCubit() : super(InitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);
  int index = 0;
  Map<int, bool> favot = {};
  List<Widget> Page = [
    ProductsPage(),
    CateogriesPage(),
    FavoritesPage(),
    SettingsPage(),
  ];

  void change_index(int value) {
    index = value;
    if (index == 1) {
      getdata();
    }
    if(index==2){
    get_favorite();
    }
    emit(ChangeIndex());
  }

  ShopHomeModel? home;
  CategoriesModel? categories;

  void getData() {
    emit(LOAD());
    DioHelper.get_data(method: 'home', toaken: takon).then((value) {
      home = ShopHomeModel.fromjson(value!.data);
      home!.data!.Products!.forEach((element) {
        favot.addAll({element.id!: element.in_favorites!});
      });
      emit(Succed());
    }).catchError((error) {
      print(error);
      emit(fail());
    });
  }

  CategoryProducts? categoryProducts;

  void change_id(String value) {
    id = value;
    emit(ChangeId());
  }

  Future<void> getdata() async {
    emit(LOAD());
    await DioHelper.get_data(toaken: takon, method: 'products', data: {
      'category_id': id,
    }).then((value) {
      categoryProducts = CategoryProducts.fromjson(value!.data);
      // print(categoryProducts!.element!.item![0].name);
      emit(Successed());
    }).catchError((error) {
      print(error);
      emit(Failed());
    });
  }

  void get_categories() {
    emit(LOAD());
    DioHelper.get_data(method: 'categories', toaken: takon).then((value) {
      categories = CategoriesModel.fromjson(value!.data);
      emit(Success());
    }).catchError((error) {
      print(error);
      emit(Fail());
    });
  }
  Favorites? favorite;
void changeFavorites(int id){
    favot[id] = !favot[id]!;
    emit(changeFavor());
    DioHelper.post_data(method: "favorites", data: {
      'product_id':id,
    },
        toaken: takon
    ).then((value)  {
   favorite=   Favorites.fromjson(value!.data);
   if(favorite!.status ==false){
     favot[id] = !favot[id]!;
   }else{
     get_favorite();
   }
   emit(Successfully(favorite));
    }).catchError((error){
      favot[id] = !favot[id]!;
      print(error);
      emit(Error());

    });
}
  GetFavirote? getFavirote;
Future<void> get_favorite() async {
  emit(sceen());

  await DioHelper.get_data(method: 'favorites',toaken:takon, ).then((value) {

    getFavirote= GetFavirote.fromJson(value!.data);
  emit(Finishs());
  });


}
void getDataproflie(){
  DioHelper.get_data(method: 'profile',toaken: takon).then((value) {
   userData=ShapeLoginModels.fromjson(value!.data);
    emit(GetUserDataSuccessed());
  }).catchError((error){
   print(error.toString());
    emit(GetUserDataFailed());
  });

}
}
