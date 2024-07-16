import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop-login-models.dart';
import 'package:shop_app/modules/login_screen/login_cubit/login_status.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStatus> {
  LoginCubit() : super(InitialStatues());

  static LoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModels ?loginModel;

  void login(String password, email) {
    emit(LoadLogin());
    DioHelper.post_data(data: {
      'email': '$email',
      'password': '$password',
    }, method: 'login')
        .then((value) {
      // print(value);
      loginModel = ShopLoginModels.fromjson(value!.data);
      emit(LoginSucceeded(loginModel!));
    }).catchError((Error) {
      print(Error.toString());
      emit(LoginFail(Error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
  // ShopLoginModels ?loginModel;

}
