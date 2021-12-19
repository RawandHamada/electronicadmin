import 'package:electronicadmin/firebase/fb_auth_controller.dart';
import 'package:flutter/material.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('الاعدادات'),
      ),
      body:   ListTile(
        onTap: () => signOut(),
        leading: Icon(Icons.logout,color:Color(0xFF4B53F5) ),
        title: Text('تسجيل الخروج '),
      ),

    );
  }
  Future<void> signOut() async {
    await FbAuthController().signOut();
    Navigator.pushReplacementNamed(context, '/login_screen');
  }

}
