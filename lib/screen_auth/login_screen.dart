
import 'package:electronicadmin/firebase/fb_auth_controller.dart';
import 'package:electronicadmin/models/user.dart';
import 'package:electronicadmin/preferences/app_preferences.dart';
import 'package:electronicadmin/utils/helpers.dart';
import 'package:electronicadmin/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  var branch;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          children: [
            SizedBox(height: 10),
            Container(
              height: 150.0,
              width: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'images/logomodal.jpg'),
                  fit: BoxFit.scaleDown,
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 10),

            Center(
              child: Text(
                'شركة مودال',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'تسجيل الدخول ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('انا لا املك حساب ؟',
                      style: TextStyle(color: Colors.grey.shade500)),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/create_accont_screen'),
                    child: Text("انشاء حساب",
                        style: TextStyle(color: Color(0XFF62BDF6))),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10),
            AppTextField(
              hint: 'البريد الالكتروني',
              controller: _emailTextController,
              maxLength: 30,

            ),
            SizedBox(height: 10),
            AppTextField(
              hint: 'كلمة المرور',
              controller: _passwordTextController,
              obscureText: true,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0XFF62BDF6),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                performSignIn();
              },
              child: Text('تسجيل الدخول'),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/forget_password_screen'),
                    child: Text("نسيت كلمة المرور",
                        style: TextStyle(color: Color(0XFF62BDF6))),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> performSignIn() async {
    if (checkData()) {
      await signIn();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: 'الرجاء ادخال البيانات!');
    return false;
  }

  Future<void> signIn() async {
    await AppPreferences().save(user: user);
    bool status = await FbAuthController().signIn(context,
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (status) {
      showSnackBar(context: context, content: 'تم تسجيل الدخول');
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context,'/main_screen');
      });
    }
  }

  Users get user {
    return Users(
        email: _emailTextController.text,
        name: 'User Name',
        uid: '', password: _passwordTextController.text
    );
  }
}
