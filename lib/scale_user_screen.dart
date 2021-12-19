
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronicadmin/firebase/fb_firestore_controller.dart';
import 'package:flutter/material.dart';


class ScaleUserScreen extends StatefulWidget {
  String uid;
  ScaleUserScreen(this.uid);
  // const ProductCategoryScreen({Key? key}) : super(key: key);

  @override
  _ScaleUserScreenState createState() => _ScaleUserScreenState();
}


class _ScaleUserScreenState extends State<ScaleUserScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print('user is in init state is ${widget.uid}');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xBF107AAA),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('الاوزان',
          style: TextStyle(color: Colors.white),),

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
              stream: FbFirestoreController().readScaleUser(path:widget.uid),
              builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
              }
              else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> data = snapshot.data!.docs;
              return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
              return Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
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
              ));
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
              'لا يوجد أوزان لهذا الموظف',
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
/*ListView(
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
        stream: FbFirestoreController().readScaleUser(path:widget.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<QueryDocumentSnapshot> data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
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
                        ));
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
                    'لا يوجد أوزان لهذا الموظف',
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
                }
              },
            ),
          ]),

* */
