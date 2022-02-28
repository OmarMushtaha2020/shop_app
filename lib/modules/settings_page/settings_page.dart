import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login.dart';
import 'package:shop_app/shared/network/local/cacth_helper.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
              child: Text(
            "SettingsPage",
            style: Theme.of(context).textTheme.bodyText1,
          )),
          MaterialButton(
            onPressed: () {
              CacthHelper.Clear('takon');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                  (route) => false);
            },
            child: Text("logo out"),
          ),
        ],
      ),
    );
  }
}
