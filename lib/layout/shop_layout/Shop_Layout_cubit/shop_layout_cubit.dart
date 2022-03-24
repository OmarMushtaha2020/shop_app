import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/models/SearchModel.dart';
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
  Map<int, bool> Favorite = {};
  List<Widget> Screen = [
    ProductsPage(),
    CateogriesPage(),
    FavoritesPage(),
    SettingsPage(),
  ];

  void change_buttons_index(int value) {
    index = value;
   if(index==0){
      get_home_data();
   }
    if (index == 1) {
      get_categories();
    }
    if(index==2){
    get_favorite();
    }
    if(index==3){
get_data_proflie();

    }
    emit(ChangeButtonsIndex());
  }

  ShopHomeModel? home;
  CategoriesModel? categories;

  void get_home_data() {
    emit(LoadGetHomeData());
    DioHelper.get_data(method: 'home', toaken: takon).then((value) {
      home = ShopHomeModel.fromjson(value!.data);
      home!.data!.Products!.forEach((element) {
        Favorite.addAll({element.id!: element.in_favorites!});

      });
      emit(GetHomeDataSuccessed());
    }).catchError((Error) {
      print(Error);
      emit(GetHomeDataFailed());
    });
  }

  CategoryProducts? categoryProducts;

  void change_categorys_id(String value) {
    id = value;
    emit(ChangeCategorysId());
  }

  Future<void> get_category_product() async {
    emit(LoadGetCategoryProduct());
    await DioHelper.get_data(toaken: takon, method: 'products', data: {
      'category_id': id,
    }).then((value) {
      categoryProducts = CategoryProducts.fromjson(value!.data);
      // print(categoryProducts!.element!.item![0].name);
      emit(GetCategorysProductSuccessed());
    }).catchError((Error) {
      print(Error);
      emit(GetCategorysProductFailed());
    });
  }

  void get_categories() {
    emit(LoadGetCategory());
    DioHelper.get_data(method: 'categories', toaken: takon).then((value) {
      categories = CategoriesModel.fromjson(value!.data);
      emit(GetCategorysSuccessed());
    }).catchError((error) {
      print(error);
      emit(GetCategorysFailed());
    });
  }
  Favorites? favorite;
void change_favorites(int id){
  Favorite[id] = !Favorite[id]!;
    emit(ChangeFavorites());
    DioHelper.post_data(method: "favorites", data: {
      'product_id':id,
    },
        toaken: takon
    ).then((value)  {
   favorite=   Favorites.fromjson(value!.data);
   if(favorite!.status ==false){
     Favorite[id] = !Favorite[id]!;
   }else {
     get_favorite();
   }
   emit(ChangeFavoritesSuccessed(favorite));
    }).catchError((Error){
      Favorite[id] = !Favorite[id]!;
      print(Error);
      emit(ChangeFavoritesFailed(Error.toString()));

    });
}
  FavoritesModel? getFavirote;
Future<void> get_favorite()  async{
  emit(GetFavoritesLoad());
  await DioHelper.get_data(method: 'favorites',toaken:takon, ).then((value) {
    getFavirote= FavoritesModel.fromJson(value!.data);
  emit(GetFaviroteSuccessed());
  }).catchError((Error){
    emit(GetFaviroteFailed());
   });


}
  ShopLoginModels ?userModel;

void get_data_proflie(){
  DioHelper.get_data(method: 'profile',toaken: takon).then((value) {
    userModel=ShopLoginModels.fromjson(value!.data);
    emit(GetUserDataSuccessed(userModel));
  }).catchError((error){
   print(error.toString());
    emit(GetUserDataFailed());
  });

}
void update_data(String name,String email,String phone){
  emit(LoadUpdateData());
DioHelper.put_data(toaken: takon,method: 'update-profile', data: {
  "name":'$name',
  "email":'$email',
  "phone":'$phone',
}).then((value) {
  userModel=ShopLoginModels.fromjson(value!.data);
emit(UpdateDataSuccessed(userModel));

}).catchError((Error){
  emit(UpdateDataFailed());
});
}

}



