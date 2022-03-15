import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/modules/search_page/search_page.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopeLayoutStates>(
      listener: (context, state) {
        if(state is ChangeFavoritesSuccessed){
        if(state.favorite!.status==false){
          showTest(state.favorite!.message!, Status.error);
        }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("salla"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ));
                  },
                  icon: Icon(Icons.search)),

            ],
          ),
          body: ShopLayoutCubit.get(context)
              .Screen[ShopLayoutCubit.get(context).index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ShopLayoutCubit.get(context).index,
            onTap: (value) {
              ShopLayoutCubit.get(context).change_buttons_index(value);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_sharp), label: "Favorites"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        );
      },
    );
  }
}
