import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/login_cubit/login_cubit.dart';
import 'package:shop_app/modules/login_screen/login_cubit/login_status.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cacth_helper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  bool ispassword = false;
  var email = TextEditingController();
  var password = TextEditingController();
  var from = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStatus>(
      listener: (context, state) {
        if (state is LoginSucceeded) {
          if (state.loginModels.status == true) {
            print(state.loginModels.message);
            print(state.loginModels.data!.toaken);
            showTest(state.loginModels.message, Status.succeeded);
            CacthHelper.saveData('takon', state.loginModels.data!.toaken)
                .then((value) {
              if (value != null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLayout()),
                    (route) => false);
              }
            });
          } else {
            print(state.loginModels.message);
            showTest(state.loginModels.message, Status.error);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: from,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.headline!.copyWith(
                            color: Colors.black,
                            fontSize: 27,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login now to browse our hot offers",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey, fontSize: 15, wordSpacing: 3),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onFieldSubmitted: (value) {
                          if (from.currentState!.validate()) {
                            LoginCubit.get(context)
                                .login(password.text, email.text);
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your email address ";
                          }
                          return null;
                        },
                        controller: email,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email Address",
                            prefixIcon: Icon(Icons.email_outlined)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: password,
                        keyboardType: TextInputType.visiblePassword,
                        onSubmit: (value) {
                          if (from.currentState!.validate()) {
                            LoginCubit.get(context).login(
                              email.text,
                              password.text,
                            );
                          }
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
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! Load,
                        builder: (context) => Container(
                          color: Colors.blue,
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              if (from.currentState!.validate()) {
                                LoginCubit.get(context)
                                    .login(password.text, email.text);
                              }
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don\'t have an account?",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegtsterScreen(),
                                    ));
                              },
                              child: Text("REGISTER")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
