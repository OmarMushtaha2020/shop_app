import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text(
        "FavoritesPage",
        style: Theme.of(context).textTheme.bodyText1,
      )),
    );
  }
}
