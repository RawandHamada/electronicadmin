import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronicadmin/details_scale_screen.dart';
import 'package:electronicadmin/firebase/fb_firestore_controller.dart';
import 'package:electronicadmin/models/scale.dart';
import 'package:electronicadmin/reports/print_arabic_invoice.dart';
import 'package:electronicadmin/utils/helpers.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ToDayScaleScreen extends StatefulWidget {



  @override
  _ToDayScaleScreenState createState() => _ToDayScaleScreenState();
}

class _ToDayScaleScreenState extends State<ToDayScaleScreen> with  Helpers {
  late Scale scale;
  List<QueryDocumentSnapshot> data = [];
 // List<Scale> scale = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async{
              await generateAndPrintArabicPdf(data: data);

            },
            icon: Icon(Icons.print),
          )
        ],
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        elevation: 1,
        backgroundColor: Color(0XFF62BDF6),
        title: Text(
          'التقرير اليومي',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: 10,),
            Container(
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('التاريخ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Cairo',color: Colors.black),),
                    Container(height: 50,width:20 , child: VerticalDivider(color: Colors.grey)),
                    Text('النوع',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Cairo',color: Colors.black),),
                    Container(height: 50,width:20 , child: VerticalDivider(color: Colors.grey)),
                    Text('اسم الزبون',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Cairo',color: Colors.black),),
                    Container(height: 50,width:20 , child: VerticalDivider(color: Colors.grey)),
                    Text('اللون',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Cairo',color: Colors.black),),
                    Container(height: 50,width:20 , child: VerticalDivider(color: Colors.grey)),
                    Text('الوزن',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Cairo',color: Colors.black),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            StreamBuilder<QuerySnapshot>(
              stream: FbFirestoreController().readScaleToday(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:5,vertical: 5
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        data[index].get('date'),
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.normal,fontFamily: 'Cairo'),
                                      ),
                                      Container(height: 50,width:20 , child: VerticalDivider(color: Colors.grey)),
                                      Text(
                                        data[index].get('nameCategory'),
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.normal,fontFamily: 'Cairo'),
                                      ),
                                      Container(height: 50,width:20 , child: VerticalDivider(color: Colors.grey)),

                                      Text(
                                        data[index].get('nameCustomer'),
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.normal,fontFamily: 'Cairo'),
                                      ),
                                      Container(height: 50,width:20 , child: VerticalDivider(color: Colors.grey)),
                                      Text(
                                        data[index].get('nameColor'),
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.normal,fontFamily: 'Cairo'),
                                      ),
                                      Container(height: 50,width:20  , child: VerticalDivider(color: Colors.grey)),
                                      Text(
                                        data[index].get('weight'),
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.normal,fontFamily: 'Cairo'),
                                      ),

                                    ],
                                  ),
                                )),
                            onTap: () {
                              Scale scale = Scale();
                              scale.path = data[index].id;
                              scale.nameCustomer = data[index].get('nameCustomer');
                              scale.weight = data[index].get('weight');
                              scale.nameCategory = data[index].get('nameCategory');
                              scale.nameBranch = data[index].get('nameBranch');
                              scale.nameColor = data[index].get('nameColor');
                              scale.date = data[index].get('date');
                              scale.time = data[index].get('time');
                              scale.title = data[index].get('title');
                              scale.pathImage = data[index].get('pathImage');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScaleScreen(scale)));
                            },
                          );
                        }),

                  );
                }
                else {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.warning, size: 85, color: Colors.grey.shade500),
                        Text(
                          'لا يوجد أوزان  ',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
        ]),
         );
  }


}
