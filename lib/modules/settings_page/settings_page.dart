import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/modules/login_screen/login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cacth_helper.dart';

class SettingsPage extends StatelessWidget {
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var from = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopeLayoutStates>(
      listener: (context, state) {
        if(state is GetUserDataSuccessed){
          var model = ShopLayoutCubit.get(context).userModel;
          email.text = model!.data!.email!;
          name.text = model.data!.name!;
          phone.text = model.data!.phone!;
        }
      },
      builder: (context, state) {

if(ShopLayoutCubit.get(context).userModel!=null){
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key:from,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              defaultFormField(
                label: "Name",
                controller: name,
                keyboardType: TextInputType.name,
                prefix: Icons.person,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Name must not be empty";
                  }
                  return null;
                },
                onChange: (value) {
                  print(value);
                },
              ),
              SizedBox(
                height: 15,
              ),
              defaultFormField(
                label: "Email Address",
                controller: email,
                keyboardType: TextInputType.emailAddress,
                prefix: Icons.email,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "email must not be empty";
                  }
                  return null;
                },
                onChange: (value) {
                  print(value);
                },
              ),
              SizedBox(
                height: 15,
              ),
              defaultFormField(
                label: "Phone",
                controller: phone,
                keyboardType: TextInputType.phone,
                prefix: Icons.phone,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "phone must not be empty";
                  }
                  return null;
                },
                onChange: (value) {
                  print(value);
                },
              ),
              SizedBox(
                height: 30,
              ),
              if(state is !LoadUpdateData)
                Container(
                  height: 50,
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      if(from.currentState!.validate()){
                        ShopLayoutCubit.get(context)
                            .update_data(name.text, email.text, phone.text);
                      }

                    },
                    child: Text(
                      "UPdate",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              if(state is LoadUpdateData)
                Center(child: CircularProgressIndicator()),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    CacthHelper.Clear('takon');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                            (route) => false);
                  },
                  child: Text(
                    "LOGOUT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

}else{
 return Center(child: CircularProgressIndicator());
}


      },
    );
  }
}
