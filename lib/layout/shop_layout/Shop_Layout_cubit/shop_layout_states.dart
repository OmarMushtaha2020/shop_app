import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/shop-login-models.dart';

class ShopeLayoutStates {}

class InitialState extends ShopeLayoutStates {}

class ChangeButtonsIndex extends ShopeLayoutStates {}

class GetHomeDataSuccessed extends ShopeLayoutStates {}
class LoadGetHomeData extends ShopeLayoutStates{}
class GetHomeDataFailed extends ShopeLayoutStates {}
class Succe extends ShopeLayoutStates {}
class LoadGetCategory extends ShopeLayoutStates {}
class GetFaviroteSuccessed extends ShopeLayoutStates {}

class GetCategorysSuccessed extends ShopeLayoutStates {}

class GetCategorysFailed extends ShopeLayoutStates {}
class UpdateDataSuccessed extends ShopeLayoutStates {
  ShopLoginModels? loginModels;
  UpdateDataSuccessed(this.loginModels);
}
class UpdateDataFailed extends ShopeLayoutStates{}
class GetCategorysProductSuccessed extends ShopeLayoutStates {}

class GetCategorysProductFailed extends ShopeLayoutStates {}

class ChangeCategorysId extends ShopeLayoutStates {}
class ChangeFavorites extends ShopeLayoutStates {}
class ChangeFavoritesFailed extends ShopeLayoutStates {
  String? errorr;
  ChangeFavoritesFailed(this.errorr);
}
class  ChangeFavoritesSuccessed extends ShopeLayoutStates {
  Favorites? favorite;
ChangeFavoritesSuccessed (this.favorite);
}
class GetUserDataSuccessed extends ShopeLayoutStates{

}
class GetUserDataFailed extends ShopeLayoutStates{

}
class SearchModelFail extends ShopeLayoutStates {
String? erorr;
SearchModelFail(this.erorr);
}
class SearchModelSuccessed extends ShopeLayoutStates{

}
class GetFaviroteFailed extends ShopeLayoutStates{

}
class GetFavoritesLoad extends ShopeLayoutStates{

}
