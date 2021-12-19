import 'package:electronicadmin/firebase/fb_notifications.dart';
import 'package:electronicadmin/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>  with FbNotifications{
  DateTime dateTime = DateTime.now();
  String time='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
    time=convertTimeDisplay(dateTime.toString());


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xBF107AAA),
        elevation: 0,
        title: Text(
          'الصفحة الرئيسية',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            icon: Icon(Icons.settings),
          )
        ],
      ),

      body: ListView(
          children:[
            Column(
              children: [
                Container(
                  height: 204,
                  width: double.infinity,
                  color: Color(0xFFBEDDFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'اهلا بك .....',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'شركة مودال للألمنيوم',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 33,
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(time),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          )
                        ],
                      ),
                      Image.asset(
                        'images/welcom.png',
                        alignment: AlignmentDirectional.bottomEnd,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: GridView(
                    padding: EdgeInsets.symmetric(horizontal: 27, vertical: 13),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 160 / 94),
                    children: [
                      buildElevatedButton(context,route:'/view_color_screen',iconImage: 'images/color.png',label: 'الالوان'),
                      buildElevatedButton(context,route:'/view_branch_screen',iconImage: 'images/factory.png',label: 'الافرع'),
                      buildElevatedButton(context,route:'/view_scale_screen',iconImage: 'images/factory.png',label: 'الأوزان'),
                      buildElevatedButton(context,route:'/view_category_screen',iconImage: 'images/factory.png',label: 'الاصناف'),
                      buildElevatedButton(context,route:'/view_employee_screen',iconImage: 'images/factory.png',label: 'الموظفين'),
                      buildElevatedButton(context,route:'/reports_screen',iconImage: 'images/factory.png',label: 'التقارير'),
                    ],
                  ),
                )],),
          ]
      ),);
  }
  ElevatedButton buildElevatedButton(BuildContext context, {required String route,required String iconImage, required String label}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(iconImage),
          SizedBox(width: 25,),
          Text(label,style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),)
        ],
      ),
      style: ElevatedButton.styleFrom(
          primary: Color(0xFFFFFFFF),
          elevation: 1,
        fixedSize: const Size(300, 100),

    ),
    );
  }
  String convertTimeDisplay(String date) {
    final displayFormater = DateFormat('yyyy-MM-dd HH:mm');
    final serverFormater = DateFormat('HH:mm');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}


