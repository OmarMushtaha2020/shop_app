import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/models/SearchModel.dart';
import 'package:shop_app/modules/search_page/search_bloc/statues.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<searchstatues>{
  SearchCubit() : super(InitialStateSearch());

 static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? searchModel;
  void  search(String text ) async {
    DioHelper.post_data(method: 'products/search', data: {
      'text':'$text',
    },toaken: takon).then((value){
      searchModel=SearchModel.fromJson(value!.data);
      emit(SearchSuccessed());
    }).catchError((Error){
      print(Error.toString());
      emit(SearchFaild(Error.toString()));
    });
  }

}