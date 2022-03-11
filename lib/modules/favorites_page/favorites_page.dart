import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/models/get_favorites.dart';
import 'package:shop_app/modules/Product_details.dart';
class FavoritesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).getFavirote!=null,
          builder:  (context) =>  Scaffold(
              body: Column(
                children: [
                  Expanded(

                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => bulid_faviters(
                            ShopLayoutCubit.get(context)
                                .getFavirote
                            !.data!.data![index].product,
                            context),
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey[200],
                        ),
                        itemCount: ShopLayoutCubit.get(context)
                            .getFavirote?.data?.data?.length??0),
                  ),
            if(ShopLayoutCubit.get(context).getFavirote!.data!.data!.length==0)
              Padding(
                padding: const EdgeInsets.only(bottom: 300),
                child: Center(child: Text('You don\'t have item')),
              ),
                ],
              )

          ),
fallback:(context) =>  Center(child: CircularProgressIndicator()),
        );


      },
    );
  }
  Widget bulid_faviters(Product? product,context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(
                            product!.image,
                            product.description,
                            product.name,
                            product.id),
                      ));
                },
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image: NetworkImage('${ product!.image}'),
                      height: 200,
                      width: 120,
                      // fit: BoxFit.cover,
                    ),
                    if (  product.discount != 0)
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
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        '${ product.name}',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.3,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Spacer(),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${  product.price}',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (  product.discount != 0)
                          Text(
                            "${  product.oldPrice}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ShopLayoutCubit.get(context).Favorite[product.id]?? true ? Colors.blue : Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              ShopLayoutCubit.get(context)
                                  .change_favorites( product.id);
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
