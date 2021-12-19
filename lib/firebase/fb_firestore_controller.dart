
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronicadmin/firebase/fb_auth_controller.dart';
import 'package:electronicadmin/models/employee.dart';
import 'package:electronicadmin/models/scale.dart';
import 'package:electronicadmin/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class FbFirestoreController{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionScale = 'Scale';
  final String _collectionUser = 'User';


  Stream<QuerySnapshot> readArray({required String nameCollection  }) async* {
    yield* _firebaseFirestore.collection('Branch').snapshots();
  }
  Stream<QuerySnapshot> readArrayColor({required String nameCollection  }) async* {
    yield* _firebaseFirestore.collection('Color').snapshots();
  }
  Stream<QuerySnapshot> readArrayCategory({required String nameCollection  }) async* {
    yield* _firebaseFirestore.collection('Category').snapshots();
  }
  Future<List<dynamic>> getArrayCategory(
      {required String nameArray}) async {
    List<dynamic> array = <dynamic>[];
    final DocumentReference document =
    _firebaseFirestore.collection('Category').doc('categories');
    await document.get().then<List<dynamic>>((DocumentSnapshot snapshot) async {
      List.from(snapshot.get(nameArray)).forEach((element) {
        String data = (element);
        array.add(data);
      });
      return array;
    });
    return array;
  }
  Future<List<dynamic>> getArrayColor(
      {required String nameArray}) async {
    List<dynamic> array = <dynamic>[];
    final DocumentReference document =
    _firebaseFirestore.collection('Color').doc('colors');
    await document.get().then<List<dynamic>>((DocumentSnapshot snapshot) async {
      List.from(snapshot.get(nameArray)).forEach((element) {
        String data = (element);
        array.add(data);
      });
      return array;
    });
    return array;
  }

  Future<List<dynamic>> getArray(
      {required String nameArray}) async {
    List<dynamic> array = <dynamic>[];
    final DocumentReference document =
    _firebaseFirestore.collection('Branch').doc('branchs');
    await document.get().then<List<dynamic>>((DocumentSnapshot snapshot) async {
      List.from(snapshot.get(nameArray)).forEach((element) {
        String data = (element);
        array.add(data);
      });
      return array;
    });
    return array;
  }

  Future<bool> updateArray(
      {required String nameDoc,
        required String nameArray,
        required List<dynamic> data}) async {
    return await _firebaseFirestore
        .collection('Branch')
        .doc('branchs')
        .update({nameArray: FieldValue.arrayUnion(data)})
        .then((value) => true)
        .catchError((error) => false);
  }
  Stream<QuerySnapshot> readUserBranch({required String type}) async* {
    yield* _firebaseFirestore.collection(_collectionUser).where("nameBranch",isEqualTo: type).snapshots();
  }
  Future<bool> CreateScale({required Scale scale, required String collectionName  }) async{
    return await _firebaseFirestore.collection(_collectionScale)
        .add(scale.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> readScale() async* {
    yield* _firebaseFirestore.collection(_collectionScale).orderBy('date', descending: true).snapshots();
  }
  Stream<QuerySnapshot> readScaleToday() async* {
    var today = DateTime.now();
    String dateFinal = convertDateTimeDisplay(today.toString());
    // today =  DateTime(today.year, today.month, today.day);
    print('today is ${dateFinal}');
    yield* _firebaseFirestore.collection(_collectionScale).where('date',isEqualTo: dateFinal).snapshots();
  }
  Stream<QuerySnapshot> readScaleMonth() async* {
    var todaymont = DateTime.now().subtract(Duration(days:30));
    var dateNowMonth = DateTime.now();
    String dateMonth = convertDateTimeDisplay(todaymont.toString());
    String dateNowFinalMonth = convertDateTimeDisplay(dateNowMonth.toString());
    print('todaymont is ${dateMonth}');
    print('todaymontdateNowFinal is ${dateNowFinalMonth}');
    yield* _firebaseFirestore.collection(_collectionScale).where('date',isGreaterThanOrEqualTo: dateNowFinalMonth).where('date',isGreaterThanOrEqualTo: dateMonth).snapshots();
  }
  Stream<QuerySnapshot> readScaleWeek() async* {
    var today = DateTime.now().subtract(Duration(days: 7));
    var dateNow2 = DateTime.now();
    String dateNowFinal2 = convertDateTimeDisplay(dateNow2.toString());
    String dateWeek = convertDateTimeDisplay(today.toString());
    print('today is ${dateNowFinal2}');
    print('todaydateWeek is ${dateWeek}');
    yield* _firebaseFirestore.collection(_collectionScale).where('date',isGreaterThanOrEqualTo: dateWeek).where('date',isLessThanOrEqualTo: dateNowFinal2).snapshots();
  }

  String convertDateTimeDisplay(String date) {
    final displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Stream<QuerySnapshot> readScaleUser({required String path}) async* {
    yield* _firebaseFirestore.collection(_collectionScale).where("uid",isEqualTo: path).snapshots();
  }
  //   Firestore  User
  Stream<QuerySnapshot> getUserData() async*{
    yield* _firebaseFirestore.collection(_collectionUser).snapshots();
  }
  Future<bool> CreateUserData(BuildContext context,{required Users user}) async{
    FbAuthController().signIn(context, email: user.email, password: user.password);
    user.uid = FbAuthController().getCurrentUserId();
    return await _firebaseFirestore.collection(_collectionUser)
        .add(user.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  //   Firestore  User

  Future<bool> updateUserData({required String path,required Users user}) async{
    return await _firebaseFirestore.collection(_collectionUser)
        .doc(path).update(user.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  //   Firestore  User

  Future<bool> deleteUserData({required String path}) async{
    return await _firebaseFirestore.collection(_collectionUser)
        .doc(path).delete()
        .then((value) => true)
        .catchError((error) => false);
  }



}

