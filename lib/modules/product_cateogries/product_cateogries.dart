import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/models/categories_products.dart';

class ProductCaterogries extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopeLayoutStates>(
    listener: (context, state) {

    },
         builder: (context, state) {
           return    Scaffold(
             appBar: AppBar(),
             body:     SingleChildScrollView(
             physics: BouncingScrollPhysics(),child: build_item(ShopLayoutCubit.get(context).categoryProducts!)),
           );

         },
    );
  }
  Widget build_item(CategoryProducts categoryProducts)=> Container(
    color: Colors.white,

    child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: 1 / 1.50,
        crossAxisCount: 2,
        children: List.generate(categoryProducts.element!.item!.length,
                (index) =>
                bulid_grid(categoryProducts.element!.item![index]))),
  ) ;
  Widget bulid_grid(Product products) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${products.image}'),
                height: 190,
                width: double.infinity,
              ),
              if (products.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${products.name}',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${products.price}",
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (products.discount != 0)
                    Text(
                      "${products.old_price}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border),
                    padding: EdgeInsets.zero,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );

}
