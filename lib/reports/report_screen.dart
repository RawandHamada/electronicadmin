import 'package:flutter/material.dart';
class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        iconTheme: IconThemeData(
            color: Colors.white
        ),
        elevation: 1,
        backgroundColor: Color(0XFF62BDF6),
        title: Text(
          'التقارير',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    body:  SizedBox(
      height: 500,
      child: GridView(
                padding: EdgeInsets.symmetric(horizontal: 27, vertical: 13),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 100 / 80),
                children: [
                  buildElevatedButton(context,route:'/today_scale_screen',iconImage: 'images/color.png',label: 'التقرير اليومي'),
                  buildElevatedButton(context,route:'/week_scale_screen',iconImage: 'images/factory.png',label: 'التقرير الاسبوعي'),
                  buildElevatedButton(context,route:'/month_scale_screen',iconImage: 'images/factory.png',label: 'التقرير الشهري'),

                ],
              ),


          ),
          );

  }

}
ElevatedButton buildElevatedButton(BuildContext context, {required String route,required String iconImage, required String label}) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(context, route);
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(iconImage),
        SizedBox(height: 25,),
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

