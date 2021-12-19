import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronicadmin/firebase/fb_firestore_controller.dart';
import 'package:electronicadmin/scale_user_screen.dart';
import 'package:flutter/material.dart';
class BranchEmployeeScreen extends StatefulWidget {
  String nameBranch;

  BranchEmployeeScreen(this.nameBranch); //const BranchEmployeeScreen({Key? key}) : super(key: key);

  @override
  _BranchEmployeeScreenState createState() => _BranchEmployeeScreenState();
}

class _BranchEmployeeScreenState extends State<BranchEmployeeScreen> {
  late String uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xBF107AAA),
        title: Text( "الموظفين",style: TextStyle(color: Colors.white),),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FbFirestoreController().readUserBranch(type: widget.nameBranch),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<QueryDocumentSnapshot> data1 = snapshot.data!.docs;
            return ListView.separated(
              itemCount: data1.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 30,
                        child: Icon(Icons.workspaces_filled, color: Color(0xBF107AAA))),
                    title: Text(data1[index].get('name')),
                    subtitle: Text(data1[index].get('nameBranch')),
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => ScaleUserScreen(data1[index].get('uid'))));
                    },


                  ),
                );

              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );

          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning, size: 85, color: Colors.grey.shade500),
                  Text(
                    "لايوجد موظفين",
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
      ) ,
    );
  }
}
