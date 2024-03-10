import 'package:cash_back/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../models/Product.dart';
import '../../shared/colors.dart';
import '../../shared/network/local/cash_helper.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../others/ProductDescreptionSceen.dart';

class FavoritsScreen extends StatefulWidget {
  const FavoritsScreen({Key? key}) : super(key: key);

  @override
  State<FavoritsScreen> createState() => _FavoritsScreenState();
}

class _FavoritsScreenState extends State<FavoritsScreen> {
  List<bool> _favoriteStatus = List.generate(3, (index) => false);
  final List<String> images = [
    'assets/images/xamarin.png',
    'assets/images/logo.png',
    'assets/images/logo.png',

  ];
  List<String> company = [
    'Prince',
    'Kinder',
    'Delice',

  ];
  List<String> favorite = [];
  List<int> _currentPages = [0,0,0];
  var productList ;
  bool _isLoading = true;

  @override
  initState()  {

     getProductData().then((value) {
      setState(() {
        _isLoading = false;
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

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(text: 'Favorite',
        pop: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: _isLoading ? Center(child: CircularProgressIndicator(),) :
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: favorite.length,
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
                              for ( final item in value!) {
                                favorite.add(item);
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

                              Text(company[index],style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,



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
      ),
    );
  }
  Future<void> getProductData() async {
    final p = <Product>[];

    final value = await CashHelper.getData(key: "id");
    print("1 $value");

    for(final i in value! ) {
      final response = await DioHelper.getData(url: 'produit/scanQRcode', data: {
        "code":"$i"
      });

      if (response.data['status'] != 'success') {
        throw Exception('Failed to fetch products');
      }

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
    }

    print("sqddddddddddddddddddddddddddddddd");
    print(p.length);

    productList = p;
  }

//   getProductData() async {
//     final p = <Product>[];
//     CashHelper.getData(
//         key: "id"
//     ).then((value) async {
//       print("1 $value");
//
//       for(final i in value! ){
//
//         print("test $i");
//
//         final response = await DioHelper.getData(url: 'produit/scanQRcode',
//             data: {
//               "code":"$i"
//             });
//
//         if (response.data['status'] != 'success') {
//           throw Exception('Failed to fetch products');
//         }
//
//
//         final data = response.data['data'] as List<dynamic>;
//
//         for (final item in data) {
//           final product = Product(
//             id: item['id'],
//             montant: item['montant'],
//             produit: item['produit'],
//             state: item['state'],
//             montantRembourse: item['montantRembourse'],
//             description: item['Description'],
//             qrcode: item['QRcode'],
//             datefinal: item['dateFinale'],
//             produitImages: item['produitImages'].cast<String>(),
//           );
//
//
//           print(product);
//           p.add(product);
//         }
//
//       }
//     });
//
// print("sqddddddddddddddddddddddddddddddd");
//
//     print(p.length);
//
//
//     productList = p;
//   }

}
