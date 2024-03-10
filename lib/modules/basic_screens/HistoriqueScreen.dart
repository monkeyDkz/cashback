import 'package:cash_back/shared/components.dart';
import 'package:cash_back/shared/network/local/cash_helper.dart';
import 'package:cash_back/shared/network/remote/dio_helper.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/Demande.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({Key? key}) : super(key: key);

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {

  int favorite = 0;
  var userId;
  var demandeList;
  int accepted = 0;
  bool _isLoading = true;
  @override
  void initState() {
    CashHelper.getData(key: 'account').then((value){
      setState(() {
        userId = value![2];
        getDemande(userId).then((value) {
          setState(() {
            _isLoading = false;
          });
        });

      });


    });

    CashHelper.getData(key: "id").then((value) {
      setState(() {
        favorite =value!.length;
      });

    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: 'History', pressed: (){},pop: false),
      body:
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: _isLoading ? Center(child: CircularProgressIndicator()) :Stack(
            children: [
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SecondText(text: 'My Dashboard'),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [

                          Expanded(
                            child: AchatStats(
                                icon: Icons.local_grocery_store_outlined,
                                firstText: '${demandeList.length}',
                                secondText: 'Requests'
                            ),
                          ),
                          Expanded(
                            child: AchatStats(
                                icon: Icons.rate_review_outlined,
                                firstText: '$accepted',
                                secondText: 'Accepted'),
                          ),
                          Expanded(
                            child: AchatStats(
                                icon: Icons.favorite_border_outlined,
                                firstText: '$favorite',
                                secondText: 'Favorite'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      SecondText(text: 'My requests'),



                    ],
                  ),

                ],
              ),
              Positioned(
                top: 200,
                bottom: 0,
                left: 0,
                right: 0,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context,index){
                    return SizedBox(
                      height: 5,
                    );
                  },
                  itemCount: demandeList.length,
                  itemBuilder: (context,index){

                    final demande = demandeList[index];
                    DateTime dateObj = DateTime.parse(demande.date);
                    DateFormat dateFormat = DateFormat("dd MMM.y");
                    String dateFr = dateFormat.format(dateObj);
                    Color c = Colors.red;
                    if(demande.state == "attend"){
                       c = Colors.orange;
                    }
                    else if (demande.state == "accepte"){
                      c = Colors.green;
                    }

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ThirdText(text: 'Demande ${dateFr}'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                               Icon(Icons.shopping_bag_outlined,color: Colors.grey,),


                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                  Row(
                                    children: [
                                      Text('Refund request',style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,

                                      ),),
                                      Text('(${demande.prod.length} artical)',style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,

                                      ),),
                                    ],
                                  ),
                                  Text('${demande.state == "accepte" ?'Accepted':"Pending"} Request  ',style: TextStyle(
                                    color: c,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,

                                  ),),

                                ],),
                              ),


                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  getDemande(var id) async {

    final response = await DioHelper.getData(url: 'demande/demandeListeByUser/$id');

    if (response.data['status'] != 'success') {
      throw Exception('Failed to fetch products');
    }

    final p = <Demande>[];
    final data = response.data['data'] as List<dynamic>;
    int t = 0 ;

    for (final item in data) {
      final product = Demande(
        id: item['id'],
        state: item['stat'],
        date: item['date'],
        prod: item['count_prod'],
        produitImages: item['images'].cast<String>(),

      );
      if(item['stat']== "accepte"){
        t++;

      }
      print(t);


      print(product);
      p.add(product);
    }
    print(p.length);

    accepted = t;
    demandeList = p;
  }
}
