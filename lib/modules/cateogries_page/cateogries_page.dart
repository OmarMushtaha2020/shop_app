import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/modules/product_cateogries/product_cateogries.dart';
import 'package:shop_app/shared/components/constant.dart';

class CateogriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(ShopLayoutCubit.get(context).categories!=null){
          return Scaffold(
              body: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => bulid_faviters(
                      ShopLayoutCubit.get(context).categories!.data!.data[index],
                      context),
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  itemCount: ShopLayoutCubit.get(context)
                      .categories!
                      .data!
                      .data
                      .length));
        }else{
        return  Center(child: CircularProgressIndicator());
        }

      },
    );
  }

  Widget bulid_faviters(Data data, context) => GestureDetector(
        onTap: () async {},
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: "${data.image}",
                height: 100,
                width: 100,
                fit: BoxFit.cover,

                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${data.name}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () async {
                  if (data.id == 44) {
                    ShopLayoutCubit.get(context).change_categorys_id('44');
                    print(id);
                    ShopLayoutCubit.get(context).get_category_product();
                 await    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductCaterogries(),
                        ));
                  } else if (data.id == 43) {
                    ShopLayoutCubit.get(context).change_categorys_id('43');
                    print(id);
                    ShopLayoutCubit.get(context).get_category_product();

                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductCaterogries(),
                        ));
                  } else if (data.id == 42) {
                    ShopLayoutCubit.get(context).change_categorys_id('42');
                    print(id);
                    ShopLayoutCubit.get(context).get_category_product();

                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductCaterogries(),
                        ));
                  } else if (data.id == 40) {
                    ShopLayoutCubit.get(context).change_categorys_id('40');
                    print(id);
                    ShopLayoutCubit.get(context).get_category_product();

                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductCaterogries(),
                        ));
                  } else {
                    ShopLayoutCubit.get(context).change_categorys_id('46');
                    ShopLayoutCubit.get(context).get_category_product();

                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductCaterogries(),
                        ));
                    print(id);
                  }
                },
              ),
            ],
          ),
        ),
      );
}
