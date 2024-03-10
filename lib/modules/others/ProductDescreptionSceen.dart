import 'package:cash_back/modules/Layout/HomeLayout.dart';
import 'package:cash_back/modules/basic_screens/HomeScreen.dart';
import 'package:cash_back/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../models/Product.dart';
import '../../shared/network/local/cash_helper.dart';
import '../../shared/network/remote/dio_helper.dart';

class ProductDescreptionSceen extends StatefulWidget {
  final String? productId;
  const ProductDescreptionSceen( { required this.productId,Key? key}) : super(key: key);

  @override
  State<ProductDescreptionSceen> createState() => _ProductDescreptionSceenState();
}

class _ProductDescreptionSceenState extends State<ProductDescreptionSceen> {
  List<String> items = [
    'Acceuil', 'Nouveautes', 'Drive',
    'petit dejener', 'jaw', 'tests',

  ];

  List<List<String>> imageUrls = [    [      'https://picsum.photos/200/300?random=1',      'https://picsum.photos/200/301?random=1',      'https://picsum.photos/200/302?random=1',    ],
    [      'https://picsum.photos/200/300?random=2',      'https://picsum.photos/200/301?random=2',      'https://picsum.photos/200/302?random=2',    ],
    [      'https://picsum.photos/200/300?random=3',      'https://picsum.photos/200/301?random=3',      'https://picsum.photos/200/302?random=3',    ],
  ];

  int _currentPages = 0;

  final List<String> images = [
    'assets/images/xamarin.png',
    'assets/images/cocacolaa.png',
    'assets/images/cocacolaaa.png',
    'assets/images/logo.png',
    'assets/images/logo.png',

  ];

  // Define a controller for the ListView
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController1 = ScrollController();
  final PageController _controller = PageController();
  bool _favoriteStatus =  false;
  int _currentPage = 0;
  int _selectedIndex = 0;
  bool _isLoading = true;
  List<String> favorite = [];
  List<Product> productList = [];
  @override
  void initState() {
    getProductData().then((value) {
      setState(() {
        _isLoading = false;
        print("done");
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


  // Define a timer to automatically scroll the ListView

  Function(int)? onPageChanged;


  @override
  Widget build(BuildContext context) {

    print(productList.length.toString());

    return Scaffold(
      appBar: AppBarComponent(text: '',
          pop:true,
        color: Color(0xffFFC0Cb),

        center: true,
          pressed: (){
            Navigator.pop(context);
    },
      ),
      backgroundColor: Color(0xffFFC0Cb),

      body:Padding(
          padding: const EdgeInsets.all(0.0),
          child: _isLoading ? Center(child: CircularProgressIndicator()) :

       Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [





          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 300.0,
                  child: PageView.builder(
                    itemCount: productList[0].produitImages.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:  Image.network("http://api.promobut.com/image/${productList[0].produitImages[i]}"),
                        // Image.network(
                        //   imageUrls[index][i],
                        //   fit: BoxFit.cover,
                        // ),
                      );
                    },
                    onPageChanged: (int i) {
                      setState(() {
                        _currentPages = i;
                      });
                    },
                    controller: PageController(initialPage: _currentPages),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Text('Product Name',style: TextStyle(color: Colors.grey,
                //       fontSize: 25,
                //       fontWeight: FontWeight.bold),),
                // ),
                Container(
                  height: 10,
                  width: double.infinity,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: productList[0].produitImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 6.0),
                          width: _currentPages == i ? 20 :10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            shape: _currentPages != i ? BoxShape.circle : BoxShape.rectangle,
                            borderRadius: _currentPages == i ?BorderRadius.circular(10) : null,
                            color: _currentPages == i
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
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 400,


            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),

                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,


                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.withOpacity(0.5)
                        ),

                      )
                    ],
                  ),
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Available until : ${productList[0].datefinal.toString().characters.take(10)} ',style: TextStyle(color: Colors.green,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),),
                          SizedBox(height: 15,),
                          Text('Nabisco',style: TextStyle(color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),),
                          SizedBox(height: 4,),
                          Text(productList[0].produit,style: TextStyle(color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),),


                        ],
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
                            if(favorite.contains("${productList[0].qrcode}")){
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  text: 'are you sure ',
                                  confirmBtnText: 'Yes',
                                  cancelBtnText: 'No',
                                  confirmBtnColor: Colors.green,
                                  onConfirmBtnTap: (){
                                    setState(() {
                                      print(productList[0].qrcode);
                                      favorite.remove("${productList[0].qrcode}");
                                      print("trah yetna7a ? $favorite");
                                      CashHelper.putData(
                                          key: 'id',
                                          value: favorite
                                      );


                                    });

                                    Navigator.pop(context);
                                    print(_favoriteStatus);


                                  }

                              );


                            }
                            else{

                              favorite.add("${productList[0].qrcode}");

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

                      }, icon: Icon( favorite.contains("${productList[0].qrcode}") ?CupertinoIcons.heart_fill : CupertinoIcons.heart),
                          color: Colors.red,
                          iconSize: 40),
                    ],
                  ),



                  SizedBox(height: 25,),

                  Row(
                    children: [
                      SizedBox(width: 7,),
                      Expanded(
                        child: Text(productList[0].description,style: TextStyle(color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.5),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 60,
                    color: Colors.grey.withOpacity(0.2),
                    thickness: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            height: 60,
                            width: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset("assets/images/offer.png",


                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${productList[0].montantRembourse} ',style: TextStyle(color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),),
                              Text('Cash Back',style: TextStyle(color: Colors.grey.withOpacity(0.8),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),),
                            ],

                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                height: 60,
                                width: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset("assets/images/dollar.png",


                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${productList[0].montant} TND',style: TextStyle(color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),),
                                  Text('Price',style: TextStyle(color: Colors.grey.withOpacity(0.8),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),),
                                ],
                              ),


                            ],
                          ),

                        ],
                      )
                    ],
                  ),



                ],
              ),
            ),
          ),



        ],
      ),
      ),








    );
  }
   getProductData() async {
    final response = await DioHelper.getData(url: 'produit/scanQRcode',
    data: {
      "code":"${widget.productId}"
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
        datefinal : item['dateFinale'],
        produitImages: item['produitImages'].cast<String>(),
      );
      print(product);
      p.add(product);
    }
    print(productList.length);



    productList = p;
  }
  //  getProductData() async {
  //   final p = <Product>[];
  //
  //   final value = await CashHelper.getData(key: "id");
  //   print("1 $value");
  //
  //   final futures = value!.map((i) async {
  //     final response = await DioHelper.getData(url: 'produit/scanQRcode', data: {
  //       "code": "$i"
  //     });
  //
  //     if (response.data['status'] != 'success') {
  //       throw Exception('Failed to fetch products');
  //     }
  //
  //     final data = response.data['data'] as List<dynamic>;
  //
  //     for (final item in data) {
  //       final product = Product(
  //         id: item['id'],
  //         montant: item['montant'],
  //         produit: item['produit'],
  //         state: item['state'],
  //         montantRembourse: item['montantRembourse'],
  //         description: item['Description'],
  //         qrcode: item['QRcode'],
  //         datefinal: item['dateFinale'],
  //         produitImages: item['produitImages'].cast<String>(),
  //       );
  //
  //       print(product);
  //       p.add(product);
  //     }
  //   });
  //
  //   await Future.wait(futures);
  //
  //   print("sqddddddddddddddddddddddddddddddd");
  //   print(p.length);
  //
  //   productList = p;
  // }


}
