
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/login.dart';
import 'package:shop_app/modules/login_screen/login_cubit/login_cubit.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/statues.dart';
import 'package:shop_app/shared/network/local/cacth_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'modules/on_boarding/on_boarding_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.inti();
await  CacthHelper.inti();
  HttpOverrides.global = new MyHttpOverrides();
bool onBoard=    CacthHelper.get_Data(key: 'onBoard');
 takon=CacthHelper.get_Data(key:'takon' );
Widget? startwidget;
  if(onBoard!=null){
    if(takon!=null){
      startwidget=ShopLayout();
    }else{
      startwidget=Login();
    }
  }else{
    startwidget=OnBoarding();
  }
  runApp(MyApp (startwidget,onBoard));

}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host,
          int port) => true;
  }
}
class MyApp  extends StatelessWidget{
Widget startwidget;
bool onBored;
  MyApp(this.startwidget,this.onBored);
  @override
  Widget build(BuildContext context) {
return MultiBlocProvider(
  providers: [
    BlocProvider(create:(context) => AppCubit()..on_bored(onBored)),
    BlocProvider(create: (context) =>  LoginCubit(),),
    BlocProvider(create: (context) => ShopLayoutCubit()..getData()..get_categories()..getdata())

  ],
  child:   BlocConsumer<AppCubit,AppStatus>(
    listener: (context, state) {

    },
    builder: (context, state) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(
                body1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
            appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white
                ),
                actionsIconTheme: IconThemeData(color: Colors.black),
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            primarySwatch: Colors.blue,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 20.0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
            ),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: HexColor("333739"),
            textTheme: TextTheme(
                body1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),

            appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: HexColor("333739"),
                ),
                backgroundColor: HexColor("333739"),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                actionsIconTheme: IconThemeData(color: Colors.white)),
            primarySwatch: Colors.blue,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 20.0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              backgroundColor: HexColor("333739"),
            ),
          ),
          themeMode: AppCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
          home:startwidget
      );
    },
  ),
);
  }
}
