import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/modules/register_screen/cubit/statues.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<ShopRegisterStates> {
  RegisterCubit() : super((ShopRegisterInitialState()));

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel?registerModel;
  void Register(String name, String email,String password,String phone){
    emit(ShopRegisterLoadingState());
    DioHelper.post_data(method: 'register', data: {
      "name":"$name",
      "email":"$email",
      "password":"$password",
      "phone":"$phone",
    }).then((value) {
      registerModel= RegisterModel.fromJson(value!.data);
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((Error){
      emit(ShopRegisterErrorState(Error.toString()));
    });

  }
  IconData icons=Icons.visibility;
  bool ispassword=true;
  void changePassword(){
    ispassword=!ispassword;
    icons=ispassword?Icons.visibility:Icons.visibility_off;
  emit(ChangePassword());
  }
}
