import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/models/get_favorites.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopeLayoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

        return ConditionalBuilder(
          condition: state is! sceen,
          builder: (context) => Scaffold(
              body:ListView.separated(itemBuilder: (context, index) => bulidFaviter(ShopLayoutCubit.get(context).getFavirote!.data!.data![index],context), separatorBuilder: (context, index) => Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[50],
              ), itemCount: ShopLayoutCubit.get(context).getFavirote!.data!.data!.length)

          ),
 fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget bulidFaviter(FData data,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${data.product!.image}'),
                height: 120,
                width:120,
                fit: BoxFit.cover,
              ),
              if (data.product!.discount!= 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.product!.name}',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                  maxLines: 1,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${data.product!.price}",
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (data.product!.discount!= 0)
                      Text(
                        "${data.product!.oldPrice}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopLayoutCubit.get(context).favot[data.product!.id]! ? Colors.blue : Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          ShopLayoutCubit.get(context).changeFavorites(data.product!.id!);
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 14.0,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
