import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cash_back/modules/others/ProductDescreptionSceen.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:cash_back/shared/components.dart';
import 'package:cash_back/shared/constant.dart';
import 'package:cash_back/shared/network/local/cash_helper.dart';
import 'package:cash_back/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'dart:async';

import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Product.dart';
import '../../shared/network/remote/dio_helper.dart';


class HomeScreene extends StatefulWidget {
  const HomeScreene({Key? key}) : super(key: key);

  @override
  State<HomeScreene> createState() => _HomeScreeneState();
}

class _HomeScreeneState extends State<HomeScreene>  {
  List<String> categorie = [
    'Home', 'Biscuits', 'Chocolate',
    'Candy', 'Cake', 'Milk','Drink'

  ];



  List<int> _currentPages = [];



  final List<String> offer = [
    'assets/images/1.jpg',

    'assets/images/2.jpg',
    'assets/images/3.jpg',



  ];
  List<String> favorite = [];

  // Define a controller for the ListView
  // final ScrollController _scrollController = ScrollController();
  // final ScrollController _scrollController1 = ScrollController();
  final PageController _controller = PageController();
  int _currentPage = 0;
  int _selectedIndex = 0;
  List<bool> _favoriteStatus = [];


  // Define a timer to automatically scroll the ListView
  Timer? _timer;

  Function(int)? onPageChanged;
  bool _isLoading = true;
  var productList;


  //////////////////












  @override
  void initState() {
    getProductData().then((value) {
      setState(() {
        _isLoading = false;
      });
    });


    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });

    CashHelper.getData(
        key: "id"
    ).then((value) {
      for (final item in value!) {
        favorite.add(item);
      }
    });
    

    super.initState();

    // Start the timer to auto-scroll the row
    // _timer = Timer.periodic(Duration(seconds: 3), (timer) {
    //   if (_scrollController.hasClients) {
    //     // Calculate the new offset by adding the width of the first item
    //     // to the current scroll offset
    //     final double newOffset = _scrollController.offset + 100.0;
    //
    //     // If the new offset exceeds the maximum scroll extent,
    //     // reset the scroll position to the beginning
    //     if (newOffset >= _scrollController.position.maxScrollExtent) {
    //       _scrollController.jumpTo(0.0);
    //     } else {
    //       _scrollController.animateTo(
    //         newOffset,
    //         duration: Duration(milliseconds: 500),
    //         curve: Curves.easeInOut,
    //       );
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Image(
          image: AssetImage('assets/images/logo-app.png'),
          height: 100,
          width: 150,
        ),
        centerTitle: true,
        primary: true,
        leading: null,
      ),


      body:

      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(

          children: [

            //carouselslider for the the societe offers
             CarouselSlider(
               items: List.generate(offer.length,
                     (index) => ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: Flex(
                     direction: Axis.horizontal,
                     children: [
                       Flexible(

                         child: Container(
                         width: MediaQuery.of(context).size.width,
                             margin: EdgeInsets.symmetric(horizontal: 1.0,
                             vertical: 10),
                             decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(15),
                           topRight: Radius.circular(15),
                           bottomLeft: Radius.circular(15),
                           bottomRight: Radius.circular(15)
                       ),
                             border: Border.all(
                       color: Colors.white,
                       width: 2
                             ),
                             color: Colors.white,
                       // boxShadow: [
                       //   BoxShadow(
                       //     color: Colors.grey.withOpacity(0.5),
                       //     spreadRadius: 5,
                       //     blurRadius: 7,
                       //     offset: Offset(0, 2), // changes position of shadow
                       //   ),
                       // ],

                             ),
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(20),
                             child: Image(image: AssetImage(offer[index]),
                               height: 240,
                               width: 250,

                              ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),

               options: CarouselOptions(

                 height: 260.0,
                 enlargeCenterPage: true,
                 autoPlay: true,
                 aspectRatio: 1 / 1,
                 autoPlayCurve: Curves.fastOutSlowIn,
                 enableInfiniteScroll: true,
                 autoPlayAnimationDuration: Duration(milliseconds: 800),
                 viewportFraction: 0.8,
               ),
             ),
            SizedBox(
              height: 20,
            ),
            // Scrolobale List for the prodact categorties
            Container(
              height: 50,

              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,

                itemBuilder: (BuildContext context, int index) {
                  // Return a widget for each item in the list
                  return CategorieList(items: categorie, index: index,
                    show: _selectedIndex == index ,
                    tab: (){
                      setState(() {
                        if(index != _selectedIndex){
                          _isLoading = true;
                          if(index == 0){
                            getProductData().then((value) {
                              setState(() {
                                _favoriteStatus = [];
                                print("tes");
                                _isLoading = false;
                              });
                            });
                          }
                          else{
                            getProductByCategorie(categorie[index]).then((value) {
                              setState(() {
                                _favoriteStatus = [];
                                print("tes");
                                _isLoading = false;
                              });
                            });

                          }
                        }




                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) => HomeScreene(),
                        //   ),
                        // );
                        _selectedIndex = index;
                      });
                    },
                    color: _selectedIndex == index ? mainColor :Colors.grey,
                  );
                },
                itemCount: categorie.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 20,
                  );
                },
              ),
            ),SizedBox(
              height: 20,
            ),



            Padding(
              padding: const EdgeInsets.all(15.0),
              child: _isLoading ? Center(child: CircularProgressIndicator()) :

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Our offers',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),),
                        Text("${productList.length.toString()} Article " ,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),),
                      ],
                    ),
                  ),
                  SizedBox( height: 10,),
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      _currentPages.add(0);
                      _favoriteStatus.add(false);

                      final product = productList[index];
                      print(index);
                      return Container(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 2
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(0, 3),

                              ),
                            ]
                        ),
                        padding: EdgeInsets.all(3.0),
                        child: MaterialButton(
                          onPressed: (){
                            

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) =>  ProductDescreptionSceen(

                                      productId: product.qrcode,
                                    )
                                ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.redAccent,
                                    ),
                                    padding: EdgeInsets.all(5),

                                    height: 30,

                                    child: Text("${product.datefinal.toString().characters.take(10)}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,

                                      ),),
                                  ),
                                  IconButton(onPressed: (){
                                    setState(() {

                                      favorite = [];
                                       CashHelper.getData(
                                         key: "id"
                                       ).then((value) {
                                         if(value != null){
                                        for ( final item in value!) {
                                          favorite.add(item);
                                        }}
                                         else{
                                           favorite = [];
                                         }
                                        if(favorite.contains("${product.qrcode}")){
                                          QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.confirm,
                                              text: 'are you sure ',
                                              confirmBtnText: 'Yes',
                                              cancelBtnText: 'No',
                                              confirmBtnColor: Colors.green,
                                              onConfirmBtnTap: (){
                                                setState(() {
                                                  print(product.qrcode);
                                                  favorite.remove("${product.qrcode}");
                                                  print("trah yetna7a ? $favorite");
                                                  CashHelper.putData(
                                                      key: 'id',
                                                      value: favorite
                                                  );
                                                  _favoriteStatus[index] = false;

                                                });

                                                Navigator.pop(context);
                                                print(_favoriteStatus);


                                              }

                                          );


                                        }
                                        else{
                                          _favoriteStatus[index] =true;
                                          favorite.add("${product.qrcode}");

                                          CashHelper.putData(
                                              key: 'id',
                                              value: favorite
                                          );

                                        }
                                       });

                                CashHelper.getData(
                                          key: "id"
                                          ).then((value) {

                                            print("teeeeeeeeeeeeeeeeeeeeee${value}");
                                            print("teeeeeeeeeeeeeeeeeeeeee${favorite}");
                                });

                                      // if(_favoriteStatus[index] == false ){
                                      //   _favoriteStatus[index] =true;
                                      // }
                                      // else if(_favoriteStatus[index] == true ){
                                      //   QuickAlert.show(
                                      //       context: context,
                                      //       type: QuickAlertType.confirm,
                                      //       text: 'are you sure ',
                                      //       confirmBtnText: 'Yes',
                                      //       cancelBtnText: 'No',
                                      //       confirmBtnColor: Colors.green,
                                      //       onConfirmBtnTap: (){
                                      //         setState(() {
                                      //           _favoriteStatus[index] = false;
                                      //         });
                                      //
                                      //         Navigator.pop(context);
                                      //         print(_favoriteStatus);
                                      //
                                      //
                                      //       }
                                      //
                                      //   );
                                      //
                                      // }







                                    });

                                  }, icon: Icon( favorite.contains("${product.qrcode}") ?CupertinoIcons.heart_fill : CupertinoIcons.heart),
                                      color: Colors.red,
                                      iconSize: 40),
                                ],
                              ),


                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [


                                        SizedBox(height: 15,),

                                        Text("TuniSolutions",style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21,



                                        ),

                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),




                                        Text(product.produit,style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,



                                        ),

                                        ),
                                        SizedBox(height: 10,),
                                        Text("${product.description.toString().characters.take(50)}...",style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 15,
                                        ),
                                        ),



                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 35,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,

                                      children: [


                                        Container(
                                          width: double.infinity,
                                          height: 150.0,
                                          child: PageView.builder(


                                            itemCount: product.produitImages.length,
                                            itemBuilder: (context,i){
                                              return ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: Image.network("http://api.promobut.com/image/${productList[index].produitImages[i]}"),
                                                // Image.network(
                                                //   imageUrls[index][i],
                                                //   fit: BoxFit.cover,
                                                // ),
                                              );

                                            },
                                            scrollDirection: Axis.horizontal,


                                            onPageChanged: (int i) {
                                              setState(() {
                                                _currentPages[index] = i;
                                              });



                                            },
                                            controller: PageController(initialPage: _currentPages[index]),
                                          ),
                                        ),
                                        SizedBox(height: 10,),

                                        Container(
                                          height: 10,
                                          width: double.infinity,
                                          child: Center(
                                            widthFactor: 179,
                                            child: ListView.builder(

                                              shrinkWrap: true,
                                              itemCount: product.produitImages.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (BuildContext context, int i) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                                                  width: 10.0,
                                                  height: 10.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _currentPages[index] == i
                                                        ? Colors.blue
                                                        : Colors.grey,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                              SizedBox(height: 10.0),

                            ],
                          ),
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                  ),
                ],
              ),




            ),




          ],
        ),
      ),




    );
  }
  getProductData() async {
    final response = await DioHelper.getData(url: 'produit/getProducts/20');

    if (response.data['status'] != 'success') {
      throw Exception('Failed to fetch products');
    }

    final p = <Product>[];
    final data = response.data['data'] as List<dynamic>;

    for (final item in data) {
      final product = Product(
        id: item['id'],
        montant: item['montant'],
        produit: item['produit'],
        state: item['state'],
        montantRembourse: item['montantRembourse'],
        description: item['Description'],
        qrcode: item['QRcode'],
        datefinal: item['dateFinale'],
        produitImages: item['produitImages'].cast<String>(),
      );


      print(product);
      p.add(product);
    }
    print(p.length);

    print("tete${p[3].produitImages}");
    productList = p;
  }
  getProductByCategorie(String cat) async{
    final response = await DioHelper.getData(url: 'produit/getByCategorie',
    data: {
      "categorie":"$cat"
    });
    if (response.data['status'] != 'success') {
      throw Exception('Failed to fetch products');
    }

    final p = <Product>[];
    final data = response.data['data'] as List<dynamic>;

    for (final item in data) {
      final product = Product(
        id: item['id'],
        montant: item['montant'],
        produit: item['produit'],
        state: item['state'],
        montantRembourse: item['montantRembourse'],
        description: item['Description'],
        qrcode: item['QRcode'],
        datefinal: item['dateFinale'],
        produitImages: item['produitImages'].cast<String>(),
      );


      print(product);
      p.add(product);
    }
    print(p.length);

    // print("tete${p[3].produitImages}");
    productList =[];
    productList = p;

  }

}
