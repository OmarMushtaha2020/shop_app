import 'package:shop_app/models/favorites_model.dart';

class ShopeLayoutStates {}

class InitialState extends ShopeLayoutStates {}

class ChangeIndex extends ShopeLayoutStates {}

class Succed extends ShopeLayoutStates {}

class fail extends ShopeLayoutStates {}

class LOAD extends ShopeLayoutStates {}
class sceen extends ShopeLayoutStates {}
class Finishs extends ShopeLayoutStates {}

class Success extends ShopeLayoutStates {}

class Fail extends ShopeLayoutStates {}

class Successed extends ShopeLayoutStates {}

class Failed extends ShopeLayoutStates {}

class ChangeId extends ShopeLayoutStates {}
class changeFavor extends ShopeLayoutStates {}
class Error extends ShopeLayoutStates {}
class Successfully  extends ShopeLayoutStates {
  Favorites? favorite;
Successfully(this.favorite);
}
class GetUserDataSuccessed extends ShopeLayoutStates{

}
class GetUserDataFailed extends ShopeLayoutStates{

}
