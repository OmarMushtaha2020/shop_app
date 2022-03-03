import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';

class Productdetails extends StatelessWidget {
  String? image;
  String? descrtion;
  String? name;
  int ?id;

  Productdetails(this.image, this.descrtion, this.name,this.id);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopeLayoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(image: NetworkImage("$image")),
                    )),
                // SizedBox(height: 100,),
                Container(
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "$name",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                            left: 20,
                          ),
                          child: Column(
                            children: [
                             Row(
                               children: [
                                 Text(
                                   "Details :",
                                   style: TextStyle(fontWeight: FontWeight.w400),
                                 ),
Spacer(),
                                 CircleAvatar(
                                   radius: 15.0,
                                   backgroundColor:
                                   ShopLayoutCubit.get(context).favot[id]!
                                       ? Colors.blue
                                       : Colors.grey,
                                   child: IconButton(
                                     onPressed: () {
                                       ShopLayoutCubit.get(context).changeFavorites(id!);
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
                              ,
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, bottom: 20, left: 20, top: 20),
                          child: Text(
                            "$descrtion",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
