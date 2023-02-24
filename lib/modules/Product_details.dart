import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/Shop_Layout_cubit/shop_layout_states.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class Productdetails extends StatefulWidget {
  String? image;
  String? descrtion;
  String? name;
  int ?id;
  Productdetails(this.image, this.descrtion, this.name,this.id);

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
int count=0;

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
                      child: CachedNetworkImage(
                        imageUrl: "${widget.image}",
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
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
                            "${widget.name}",
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
                                   ShopLayoutCubit.get(context).Favorite[widget.id]!
                                       ? Colors.blue
                                       : Colors.grey,
                                   child: IconButton(
                                     onPressed: () {
                                       ShopLayoutCubit.get(context).change_favorites(widget.id!);
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
                            "${widget.descrtion}",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ),
           Padding(
             padding: const EdgeInsets.only(left: 20),
             child: Row(
               children: [
                 FloatingActionButton(mini: true,onPressed:  () {
setState(() {
  count--;
});
                 },child: Padding(
                   padding: const EdgeInsets.only(bottom: 15),
                   child: Icon(Icons.minimize_rounded),
                 ),),
Text("$count",style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 25
),),
                 FloatingActionButton(mini: true,onPressed:  () {
setState(() {
  count++;
});
                 },child: Icon(Icons.add),),
              SizedBox(width: 20,),

                 GestureDetector(
                   onTap: () {
                     setState(() {
                       ShopLayoutCubit.get(context).addToCart();
                     });

                   },
                   child: Container(
                     child: Center(
                       child: Text("Add to cart",style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.w600,

                       )),
                     ),
                     width: 120,
                     height: 40,
                     decoration: BoxDecoration(
                       color: Colors.blue,

                       borderRadius: BorderRadius.only(
                         bottomRight: Radius.circular(10)
                             ,
                         topLeft: Radius.circular(10)
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           )
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
class CartModel {
  bool? status;
  Dataes? data;


  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Dataes.fromJson(json['data']) : null;
  }

}

class Dataes {
  List<CartItems>? cartItems;
  int? subTotal;
  int? total;


  Dataes.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }

}

class CartItems {
  int? id;
  int? quantity;
  Productes? product;


  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? new Productes.fromJson(json['product']) : null;
  }

}

class Productes {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;



  Productes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
