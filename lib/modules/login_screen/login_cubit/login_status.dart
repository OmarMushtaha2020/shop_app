import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/models/shop-login-models.dart';

abstract class LoginStatus {}

class InitialStatues extends LoginStatus {}

class Changes extends LoginStatus {}

class Load extends LoginStatus {}

class Login extends LoginStatus {}
class Register extends LoginStatus{
  ShapeLoginModels? userData;

  Register(this.userData);
}
class RegisterFail extends LoginStatus{
  String error;
  RegisterFail(this.error);
}

class LoginSucceeded extends LoginStatus {
  ShapeLoginModels loginModels;

  LoginSucceeded(this.loginModels);
}

class ShopChangePasswordVisibilityState extends LoginStatus {}

class LoginFail extends LoginStatus {
  final String? error;

  LoginFail(this.error);
}
