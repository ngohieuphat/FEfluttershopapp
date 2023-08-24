import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../controllers/login_provider.dart';
import '../../../models/auth/login_model.dart';
import '../../shared/appstyle.dart';
import '../../shared/customtextfield.dart';
import '../../shared/resusable_text.dart';
import 'register.dart';
import '../mainscreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPgaeState();
}

class _LoginPgaeState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool validation = false;

  void formValidation() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context , listen: false);
    return  Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 50.h,
              backgroundColor: Colors.black,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.5, image: AssetImage("assets/images/bg.jpg"))),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  reusableText(
                      text: "Welcome!",
                      style: appstyle(30, Colors.white, FontWeight.w600)),
                  reusableText(
                      text: "Fill in your details to login into your account",
                      style: appstyle(14, Colors.white, FontWeight.w600)),
                  SizedBox(
                    height: 50.h,
                  ),
                  CustomTextField(
                    keyboard: TextInputType.emailAddress,
                    hintText: "Emaill",
                    controller: email,
                    validator: (email) {
                      if (email!.isEmpty && !email.contains("@")) {
                        return 'Please provide valid email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    obscureText: authNotifier.isObsecure,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          authNotifier.isObsecure = !authNotifier.isObsecure;
                        },
                        child: authNotifier.isObsecure
                            ? Icon(
                                Icons.visibility_off,
                              )
                            : Icon(
                                Icons.visibility,
                              )),
                    hintText: "Password",
                    controller: password,
                    validator: (password) {
                      if (password!.isEmpty && password.length < 7) {
                        return 'Password too weak';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reistration()));
                      },
                      child: reusableText(
                          text: "Register",
                          style: appstyle(14, Colors.white, FontWeight.w500)),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      formValidation();
                      if (validation == true) {
                        LoginModel model = LoginModel(
                            email: email.text, password: password.text);
                        authNotifier.userLogin(model).then((response) {
                          if (response == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()));
                          } else {
                            debugPrint("Failed to login");
                          }
                        });
                      } else {
                        debugPrint("form not validated");
                      }
                    },
                    child: Container(
                      height: 55.h,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                        child: reusableText(
                            text: "L O G I N",
                            style: appstyle(18, Colors.black, FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
