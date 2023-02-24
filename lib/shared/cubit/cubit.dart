import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/statues.dart';

class AppCubit extends Cubit<AppStatus> {
  AppCubit() : super(InitialStatus());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void change_mode() {
    isDark = !isDark;
    emit(ChangeMode());
  }

  bool is_bored = false;

  void on_bored(bool value) {
    if (value != null) {
      is_bored = value;
      emit(OnBred());
    } else {
      is_bored = false;
      emit(OnBred());
    }
  }
}
