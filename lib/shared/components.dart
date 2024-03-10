


import 'package:cash_back/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../test.dart';

Widget OfferSlides({
  required List<String> images,
  required int index,
})=>
Container(
margin: EdgeInsets.all(8.0),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10.0),
image: DecorationImage(
image:  AssetImage(images[index]),
fit: BoxFit.cover,
),
),
);


Widget CategorieList({
  required List<String> items,
  required int index,
  required Function tab,
  required Color color,
  required bool show

})=>

Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child:   Column(

    children: [

      InkWell(

        onTap: (){

          tab();

        },

        child: Text(items[index],style: TextStyle(

          color: color,

          fontSize: 20,

          fontWeight: FontWeight.w400,

        ),),

      ),

          Visibility(

             visible:show ,

            child: Padding(

              padding: const EdgeInsets.all(3.0),

              child: Container(

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),

                  color: mainColor,

                ),

                width: 20,

      height: 6,



      ),

            ),

          ),

    ],

  ),
);

Widget Articals({
  required List<String> Images,
  required String BrandImage,
  required String ProductName,
  required String ProductDiscription,
  required Function PageChanged,




})=>
Padding(
padding: const EdgeInsets.all(10.0),
child: Column(
children: [
Padding(
padding: const EdgeInsets.symmetric(vertical: 5),
child: ClipRRect(
borderRadius: BorderRadius.circular(10) ,
child: Container(
color: Colors.blueAccent,
width: double.infinity,
height: 200,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.start,
children: [
Expanded(
flex: 1,
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
SizedBox(height: 15,),

CircleAvatar(
backgroundImage: AssetImage(BrandImage),
backgroundColor: Colors.grey[400],
radius: 35,
),
SizedBox(
height: 20,
),

Text(ProductName,style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 16,



),

),
SizedBox(height: 10,),
Text(ProductDiscription,style: TextStyle(
color: Colors.grey,
fontSize: 12,
),
),



],
),
),
SizedBox(
width: 20,
),
Expanded(
flex: 1,
child: Stack(
children: [
PageView.builder(
onPageChanged: (int index) {
PageChanged();
},
itemCount: Images.length,
itemBuilder: (context,index){
//_currentPage = index;
//print(_currentPage);
return Column(
children: [
Container(
height: 140,
child: Image(image: AssetImage(Images[index]),
fit: BoxFit.cover,
color: Colors.grey,
),
),
],
);

}),
SizedBox(
height: 10,
),
Positioned(
left: 10,
right: 10,
bottom: 15,

child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: List.generate(Images.length, (index) {
return Text('data');
// return  CustomIndicator(
//   itemCount: count,
//   currentIndex: currentindex,
//     );
}),
),
),
],
)
),
],
),
),

),
),
),

],
),
);


//stats in achat
Widget AchatStats({
  required IconData icon,
  required String firstText,
  required String secondText,


})=>
   Column(

  children: [

  Icon(icon,color: secondTextColor, size: 30,),

  Padding(

    padding: const EdgeInsets.all(10.0),

    child:   Text(firstText,style: TextStyle(



    color: mainColor,



    fontWeight: FontWeight.bold,



    fontSize: 20,







    ),),

  ),

  Text(secondText,style: TextStyle(

  color: secondTextColor,

  fontWeight: FontWeight.bold,

  fontSize: 18,



  ),),

  ],


);
Widget FirstText({
  required String text,

})=>
Text(text,style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 30,
color: textColors
),);
Widget SecondText({
  required String text,
  Color color = textColors,
  double fontSize = 15



})=>
    Text(text,style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: textColors,

    ),textAlign: TextAlign.center,);


Widget ThirdText({
  required String text,
  Color color= textColors,


})=>
    Text(text,style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: color,
    ),);
Widget HistoriqueAchat({
  required String dateDemande,
  required String price,
  required String image,




})=>
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
ThirdText(text: dateDemande),
ThirdText(text: price ,color: secondTextColor)
],
),
SizedBox(
height: 10,
),
Row(
children: [
Image(image: AssetImage('assets/images/$image'),
height: 30,),
SizedBox(
width: 20,
),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('le fromage foute madame loik',style: TextStyle(
color: Colors.pink,
fontWeight: FontWeight.bold,
fontSize: 20,

),),
Text('remboursement effectue',style: TextStyle(
color: Colors.black,
fontWeight: FontWeight.w400,
fontSize: 15,

),),

],),

],
)
],
);











// oficielement Widget 7adrin w mriglin



// app bar component
PreferredSizeWidget AppBarComponent({
  required String text,
  Function? pressed,
  bool pop = false,
  bool center = false,
  Color color = Colors.white,
  List<Widget>? action,


})=>
AppBar(
  automaticallyImplyLeading: false,

backgroundColor: color,
elevation: 0,
centerTitle: center,
title: FirstText(text: text),
  leading:pop ?IconButton(
    onPressed: (){
      pressed!();
    },
    icon: Icon(Icons.arrow_back_ios_new,
    color: mainColor,),
  ):null,
  actions: action,

);


// login button is the buuton of sign in and sign up oin diffrent pages
Widget LoginButton({
  required Color ContainerColor ,
  required String text,
  required Function pressed
})=>
Container(
width: double.infinity,
decoration: BoxDecoration(
color: ContainerColor,
borderRadius: BorderRadius.circular(8),
),

child: TextButton(onPressed: (){
  pressed();
},
child: Text(text,
style: TextStyle(
fontWeight: FontWeight.w500,
color: Colors.white,
fontSize: 22
),),),
);

// Text Form field for all form fields in the app

Widget defaultFormField({
  required TextEditingController contoller,
  required TextInputType type,
  Function? submited,
  Function? change,
  Function? tab,
  Function? suffixPressed,
  required Function validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  bool isPassword =false,
  Color color = Colors.pink,


})=>
    TextFormField(

      controller: contoller ,
      keyboardType: type,

      validator: (String? value){
         return validate(value);
      },
      onFieldSubmitted: (String value)
      {
        submited!(value);
      },
      onChanged: (String value)
      {
        change!(value);
      },
      onTap: ()
      {
        tab!();
      },

      style: TextStyle(fontSize: 22.0, color: Colors.black),

      cursorColor: color ,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.grey[200],
        filled: true,
        labelStyle:  TextStyle(
            fontSize: 20,
            color: color,
            fontWeight: FontWeight.w500
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              color: color,
              width: 3
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),




        prefixIcon: prefix != null ? Icon(prefix,
          color:color,
        ) : null,
        suffixIcon: suffix != null ? IconButton(icon: Icon(suffix,color: mainColor,),onPressed: (){
          suffixPressed!();
        },
        ) : null,

      ),
    );
Widget AchatStatsProfile({
  required IconData icon,
  required String firstText,
  required String secondText,


})=>
    Container(

decoration: BoxDecoration(
color: Colors.grey[200],
borderRadius: BorderRadius.circular(10)
),
child: Column(
      children: [
        Icon(icon,color: secondTextColor,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:   Text(firstText,style: TextStyle(

            color: mainColor,

            fontWeight: FontWeight.bold,

            fontSize: 20,



          ),),
        ),
        Text(secondText,style: TextStyle(
          color: secondTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,

        ),),
      ],
),
    );

Widget RemboursementSteps({
  required int id,
  required String number,
  required String text,
  required IconData icon,

})=>
Column(
crossAxisAlignment: CrossAxisAlignment.center,

children: [
CircleAvatar(

child: Icon(icon,
size: 40,
color: Colors.white),
backgroundColor: mainColor,
radius: 35,
),

Padding(
padding: const EdgeInsets.all(8.0),
child: Text('$number',style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Colors.black
),),
),
Padding(
padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
child: Center(
child: SecondText(
text: '$text',
color: Colors.grey,
fontSize: 20),
),
),
 id != 3 ? Container(
color: mainColor,
width: 2,
height: 50,
):SizedBox(),



],
);
Widget NBbutton({
  int? pageIndex,
  required Function pressed,
  required String text,
  IconData? iconFirst,
  IconData? iconSecond,


})=>
    Visibility(
      visible:  pageIndex==0?false:true,
      child: Container(

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(5),
          color: mainColor,
        ),

        child: MaterialButton(onPressed: (){
          pressed();
        }, child:
        Row(
          children: [
            Icon(iconFirst,
              color: Colors.white,),
            Visibility(
              visible: iconFirst==null?false:true,
              child:   SizedBox(

                width: 20,

              ),
            ),
            Text(text,
              style: TextStyle(
                  color: Colors.white
              ),),
            Visibility(
              visible: iconSecond==null?false:true,
              child: SizedBox(
                width: 20,
              ),
            ),
            Icon(iconSecond,
              color: Colors.white,),
          ],
        ),
        ),
      ),
    );

