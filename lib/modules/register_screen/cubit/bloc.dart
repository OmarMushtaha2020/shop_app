import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/modules/register_screen/cubit/statues.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<ShopRegisterStates> {
  RegisterCubit() : super((ShopRegisterInitialState()));

  static RegisterCubit get(context) => BlocProvider.of(context);


  // IconData suffix = Icons.visibility_outlined;
  // bool isPassword = true;

  // void changePasswordVisibility() {
  //   isPassword = !isPassword;
  //   suffix =
  //   isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  //   emit(ShopChangePasswordVisibilityState());
  // }
  RegisterModel?registerModel;
  void register( name, email, password, phone){
    DioHelper.post_data(method: 'register', data: {
      "name":name,
      "email":email,
      "password":password,
      "phone":phone,
    }).then((value) {
      registerModel= RegisterModel.fromJson(value!.data);
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((Error){
      emit(ShopRegisterErrorState(Error.toString()));
    });
  }
}
