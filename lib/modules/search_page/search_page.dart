import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/models/SearchModel.dart';
import 'package:shop_app/modules/Product_details.dart';
import 'package:shop_app/modules/search_page/search_bloc/bloc.dart';
import 'package:shop_app/modules/search_page/search_bloc/statues.dart';

class SearchPage extends StatelessWidget {
var text=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,searchstatues>(
        listener:  (context, state) {

        },
        builder: (context, state) {
      return  Scaffold(
            appBar: AppBar(),
            body: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: text,
                    onChanged: (String value) {
SearchCubit.get(context).search(value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(

                      )
                      ,prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
               if(state is SearchSuccessed)
                Expanded(

                  child: ListView.separated(physics: BouncingScrollPhysics(),itemBuilder: (context, index) =>
          get_search_product(SearchCubit.get(context).searchModel!.data!.pc![index],context
          ,false)

                      , separatorBuilder: (context, index) => Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[100],
                  ), itemCount: SearchCubit.get(context).searchModel!.data!.pc!.length
                  ),
                ),

                if(SearchCubit.get(context).searchModel==null)
                  Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: Text("Please enter the item"),
                  ),

              ],
            ),
          );

        },
      ),
    );
  }
Widget get_search_product( Products product,context,bool isbored) => Padding(
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
                      product.image,
                      product.description,
                      product.name,
                      product.id),
                ));
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CachedNetworkImage(
                imageUrl: "${product.image}",
                height: 200,
                width: 120,
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),              if (product.price != 0&&isbored)
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
                  '${product.name}',
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
                    '${product.price}',
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (product.price != 0&&isbored)
                    Text(
                      "${product.price}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor: ShopLayoutCubit.get(context)
                        .Favorite[product.id]??true
                        ? Colors.blue
                        : Colors.grey,
                    child: IconButton(
                      onPressed: () {
                        ShopLayoutCubit.get(context).change_favorites(product.id!);
                        print("S");
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
