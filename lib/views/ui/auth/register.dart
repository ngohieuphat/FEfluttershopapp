import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shopappcourse/controllers/login_provider.dart';
import 'package:shopappcourse/models/auth/signup_model.dart';
import 'package:shopappcourse/views/shared/appstyle.dart';
import 'package:shopappcourse/views/shared/customtextfield.dart';
import 'package:shopappcourse/views/shared/resusable_text.dart';
import 'package:shopappcourse/views/ui/auth/login.dart';

class Reistration extends StatefulWidget {
  const Reistration({super.key});

  @override
  State<Reistration> createState() => _ReistrationState();
}

class _ReistrationState extends State<Reistration> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  bool validation = false;

  void formValidation() {
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        username.text.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
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
                text: "Fill in your details to sign up for an account",
                style: appstyle(14, Colors.white, FontWeight.w600)),
            SizedBox(
              height: 50.h,
            ),
            CustomTextField(
              keyboard: TextInputType.emailAddress,
              hintText: "UserName",
              controller: username,
              validator: (username) {
                if (username!.isEmpty) {
                  return 'Please provide valid username';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 15.h,
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: reusableText(
                    text: "Lgoin",
                    style: appstyle(14, Colors.white, FontWeight.w500)),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
              onTap: () {
                formValidation();
                if (validation) {
                  SignupModel model = SignupModel(
                      username: username.text,
                      email: email.text,
                      password: password.text);
                  authNotifier.registerUser(model).then((response) {
                    if (response == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    } else {
                      debugPrint("Fail signup");
                    }
                  });
                } else {
                  debugPrint("form not valid");
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
                      text: "S I G N U P",
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
