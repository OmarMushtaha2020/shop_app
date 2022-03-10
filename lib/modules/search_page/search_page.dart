import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/models/SearchModel.dart';
import 'package:shop_app/modules/Product_details.dart';

class SearchPage extends StatelessWidget {
var text=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopeLayoutStates>(
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
ShopLayoutCubit.get(context).search(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(

                    )
                    ,prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
             if(state is SearchModelSuccessed)
              Expanded(

                child: ListView.separated(physics: BouncingScrollPhysics(),itemBuilder: (context, index) =>
        get_search_product(ShopLayoutCubit.get(context).searchModel!.data!.pc![index],context
        )

                    , separatorBuilder: (context, index) => Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[100],
                ), itemCount: ShopLayoutCubit.get(context).searchModel!.data!.pc!.length
                ),
              )
            ],
          ),
        );

      },
    );
  }
Widget get_search_product( Product product,context) => Padding(
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
              Image(
                image: NetworkImage('${product.image}'),
                height: 200,
                width: 120,
                // fit: BoxFit.cover,
              ),
              if (product.price != 0)
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
                  if (product.price != 0)
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
                        .Favorite[product.id]!
                        ? Colors.blue
                        : Colors.grey,
                    child: IconButton(
                      onPressed: () {
                        ShopLayoutCubit.get(context).change_favorites(product.id!);
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
