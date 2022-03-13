import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/login_cubit/login_cubit.dart';
import 'package:shop_app/modules/register_screen/cubit/bloc.dart';
import 'package:shop_app/modules/register_screen/cubit/statues.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/local/cacth_helper.dart';

class RegtsterScreen extends StatelessWidget {


  bool ispasswords = false;
  var emails = TextEditingController();
  var phones = TextEditingController();
  var names = TextEditingController();
  var passwords = TextEditingController();
  var froms = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return BlocProvider(
   create:  (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel!.status!) {
              print(state.registerModel!.message);
              print("eedw${state.registerModel!.data!.token}");
              showTest(state.registerModel!.message!, Status.succeeded);

              CacthHelper.saveData('takon', state.registerModel!.data!.token).then((value) {
                print(value);
                  takon=state.registerModel!.data!.token!;
                  ShopLayoutCubit.get(context).get_data_proflie();
                ShopLayoutCubit.get(context).get_favorite();
                ShopLayoutCubit.get(context).get_home_data();
                ShopLayoutCubit.get(context).get_category_product();
                ShopLayoutCubit.get(context).get_categories();
                Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ShopLayout()),
                          (route) => false);
                }

            );
            } else {
              print(state.registerModel!.message);
              showTest(state.registerModel!.message!, Status.error);
            }
          }

        },
        builder:  (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: froms,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "REGISTER",
                            style: Theme.of(context).textTheme.headline!.copyWith(
                                color: Colors.black,
                                fontSize: 27,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Register now to browse our hot offers",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey, fontSize: 15, wordSpacing: 3),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your Name address ";
                              }
                              return null;
                            },
                            controller: names,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: " Name",
                                prefixIcon: Icon(Icons.person)),
                          ),
                          SizedBox(height: 15,),

                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your email address ";
                              }
                              return null;
                            },
                            controller: emails,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email Address",
                                prefixIcon: Icon(Icons.email_outlined)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: passwords,
                            keyboardType: TextInputType.visiblePassword,
                            onSubmit: (value) {

                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: LoginCubit.get(context).suffix,
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                          ),
                          SizedBox(height: 15,),
                          TextFormField(

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your phone  ";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              if(froms.currentState!.validate()){
                                RegisterCubit.get(context).register(
                                  names.text,
                                  emails.text,
                                  passwords.text,
                                  phones.text,
                                );
                              }
                            },
                            controller: phones,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Phone",
                                prefixIcon: Icon(Icons.phone)),
                          ),

                          SizedBox(
                            height: 30,
                          ),
                             Container(
                              color: Colors.blue,
                              width: double.infinity,
                              height: 50,
                              child: MaterialButton(
                                onPressed: () {
                                  if (froms.currentState!.validate()) {
                                    RegisterCubit.get(context).register(
                                      names.text,
                                      emails.text,
                                      passwords.text,
                                      phones.text,
                                    );
                                  }
                                },
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
