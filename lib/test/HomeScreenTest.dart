

import 'dart:async';

import 'package:flutter/material.dart';

import '../models/Product.dart';
import '../shared/network/remote/dio_helper.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final PageController _pageController = PageController();
  final StreamController<int> _pageStreamController = StreamController<int>();
  int _currentIndex = 0;


    Future<List<String>> _getData() async {
      final response = await DioHelper.getData(url: 'produit/getProducts/20');

      if (response.data['status'] != 'success') {
        throw Exception('Failed to fetch products');
      }

      final productList = <Product>[];
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
        productList.add(product);
      }
      print(productList.length);

      print("tete${productList[3].produitImages}");
List<String> t = ["tes","test"];
      return t;
    }

  @override
  void dispose() {
    _pageStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return StreamBuilder<int>(
              stream: _pageStreamController.stream,
              initialData: _currentIndex,
              builder: (BuildContext context, AsyncSnapshot<int> pageSnapshot) {
                return PageView.builder(
                  controller: _pageController,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MyPageWidget(
                      data: snapshot.data![index],
                      onPageChange: (int newIndex) {
                        setState(() {
                          _currentIndex = newIndex;
                          _pageStreamController.add(newIndex); // Update the stream with the new index
                        });
                      },
                    );
                  },
                  onPageChanged: (int newIndex) {
                    _pageStreamController.add(newIndex); // Update the stream with the new index
                  },
                  physics: const NeverScrollableScrollPhysics(), // Disable scrolling of PageView
                  pageSnapping: true,


                );
              },
            );
          }
        },
      ),
    );
  }
}

class MyPageWidget extends StatefulWidget {
  final String data;
  final ValueChanged<int> onPageChange;

  MyPageWidget({required this.data, required this.onPageChange});

  @override
  _MyPageWidgetState createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _counter++;
        });
        widget.onPageChange(_counter);
      },
      child: Center(
        child: Text('${widget.data}: $_counter'),
      ),
    );
  }
}
