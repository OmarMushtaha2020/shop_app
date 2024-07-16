import 'package:shop_app/models/register_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates
{
RegisterModel? registerModel;
  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends ShopRegisterStates
{
   String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}
class ChangePassword extends ShopRegisterStates {}