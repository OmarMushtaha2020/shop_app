
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/login_screen/login.dart';
import 'package:shop_app/shared/network/local/cacth_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class Model{
 late String text_1;
 late String text_2;
 late String image;
 Model(this.image,this.text_1,this.text_2);
}
class  OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  List<Model>items=[
  Model("assets/images/shop3.png", "On Board 1", "On Board 1 Body"),
  Model("assets/images/shop3.png", "On Board 2", "On Board 2 Body"),
  Model("assets/images/shop3.png", "On Board 3", "On Board 3 Body"),

];

var on_board=PageController();

bool is_board=false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
actions: [
  TextButton(onPressed: () {
    CacthHelper.saveData('onBoard',true).then((value) {
      if(value!){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);

      }
    });
  }, child: Text("SKIP")),
],
      ),
body:Padding(
  padding: const EdgeInsets.all(30.0),
  child:   Column(

    children: [

      Expanded(

        child: PageView.

        builder(onPageChanged: (value) {
         if(value==items.length-1){
           setState(() {
             is_board=true;
           });
         } else{
           setState(() {
             is_board=false;
           });
         }
        },itemBuilder: (context, index) => bulid_item(items[index]),itemCount: items.length,physics: BouncingScrollPhysics(),controller:on_board,),

      ),
SizedBox(height: 40,),
      Row(children: [
SmoothPageIndicator(controller: on_board, count: items.length,effect:ExpandingDotsEffect(
  dotColor:Colors.grey,
  dotHeight: 10,
  expansionFactor: 4,
    dotWidth: 10,
  spacing: 5.0,
  activeDotColor: HexColor("00B0FF"),

) ,),
        Spacer(),
        Container(

          child: FloatingActionButton(backgroundColor: HexColor("00B0FF"),onPressed: () {
            if(is_board){
              CacthHelper.saveData('onBoard',true).then((value) {
                if(value!){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);

                }
              });
            }else{
              on_board.nextPage(duration: Duration(
                milliseconds: 750,
              ), curve:Curves.fastLinearToSlowEaseIn );

            }

          },child: Icon(Icons.arrow_forward_ios),),
        )
      ],)
    ],

  ),
)
    );
  }

Widget bulid_item(Model item)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Expanded(child: Image(image: AssetImage("${item.image}"))),
    Text("${item.text_1}",style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,

    ),),
    SizedBox(height: 15,),
    Text("${item.text_2} ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
    SizedBox(height: 30,),

  ],
);
}
