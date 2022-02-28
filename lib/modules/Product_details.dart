import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Productdetails extends StatelessWidget {
  String? image;
  String? eext;
  String? name;

  Productdetails(this.image,this.eext,this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       Expanded(child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Image(image: NetworkImage("$image")),
       )),
          // SizedBox(height: 100,),
          Container(
          width: double.infinity,height: 250,child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("$name",style: TextStyle(
                  fontWeight: FontWeight.w400,

                  ),maxLines: 1,),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20,),
                  child: Text("Details :",style: TextStyle(
                    fontWeight: FontWeight.w400
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20,bottom: 20,left: 20,top: 20),
                  child: Text("$eext",style: TextStyle(
                    fontWeight: FontWeight.w400,
                    height:1.5,

                  ),),
                ),
              ],
            ),
          ),decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(topLeft:  Radius.circular(40),topRight: Radius.circular(40)),

          ),),
        ],
      )
    );
  }
 
}
