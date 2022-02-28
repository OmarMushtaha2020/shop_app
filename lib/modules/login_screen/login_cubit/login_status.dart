import 'package:shop_app/models/shop-login-models.dart';

abstract class LoginStatus {}

class InitialStatues extends LoginStatus {}

class Changes extends LoginStatus {}

class Load extends LoginStatus {}

class Login extends LoginStatus {}

class LoginSucceeded extends LoginStatus {
  ShapeLoginModels loginModels;

  LoginSucceeded(this.loginModels);
}

class ShopChangePasswordVisibilityState extends LoginStatus {}

class LoginFail extends LoginStatus {
  final String? error;

  LoginFail(this.error);
}
