import 'package:shop_app/models/shop-login-models.dart';

abstract class LoginStatus {}

class InitialStatues extends LoginStatus {}

class Changes extends LoginStatus {}

class LoadLogin extends LoginStatus {}

class Login extends LoginStatus {}
class RegisterSucceeded extends LoginStatus{
  ShopLoginModels? userData;

  RegisterSucceeded(this.userData);
}
class RegisterFail extends LoginStatus{
  String error;
  RegisterFail(this.error);
}

class LoginSucceeded extends LoginStatus {
  ShopLoginModels loginModels;

  LoginSucceeded(this.loginModels);
}

class ShopChangePasswordVisibilityState extends LoginStatus {}

class LoginFail extends LoginStatus {
  final String? error;

  LoginFail(this.error);
}
