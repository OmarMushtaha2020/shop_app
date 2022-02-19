import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/product_cateogries/product_cateogries.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).home != null &&
              ShopLayoutCubit.get(context).categories != null,
          builder: (context) => bulid_products(
              ShopLayoutCubit.get(context).home!,
              ShopLayoutCubit.get(context).categories!),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget bulid_products(ShopHomeModel home, CategoriesModel categories) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: home.data!.banners!
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 1.0,
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          bulid_categories(categories.data!.data[index],context),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categories.data!.data.length)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "New Products",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1 / 1.50,
                  crossAxisCount: 2,
                  children: List.generate(
                      home.data!.Products!.length,
                      (index) =>
                          bulid_grid_products(home.data!.Products![index]))),
            ),
          ],
        ),
      );

  Widget bulid_grid_products(Broducts products) => Container(
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

  Widget bulid_categories(Data data,context) =>
      Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onTap: () async{
                  if(data.id==44){
                    ShopLayoutCubit.get(context).change_id('44');
                    print(id);
                    await     ShopLayoutCubit.get(context).getdata();
                 Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCaterogries(),));

                  }else if(data.id==43){
                    ShopLayoutCubit.get(context).change_id('43');
                    print(id);
                    await ShopLayoutCubit.get(context).getdata();
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCaterogries(),));

                  }else if(data.id==42){
                    ShopLayoutCubit.get(context).change_id('42');
                    print(id);
                    await  ShopLayoutCubit.get(context).getdata();
               Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCaterogries(),));

                  }else if(data.id==40){
                    ShopLayoutCubit.get(context).change_id('40');

                    await ShopLayoutCubit.get(context).getdata();
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCaterogries(),));

                  }else{
                    ShopLayoutCubit.get(context).change_id('46');
                    await ShopLayoutCubit.get(context).getdata();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCaterogries(),));

                    print(id);

                  }
                },
                child: Image(
                  image: NetworkImage("${data.image}"),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 100,
                color: Colors.black.withOpacity(.5),
                child: Text(
                  "${data.name}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
}
