import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopappcourse/controllers/cart_provider.dart';
import 'package:shopappcourse/controllers/favorites_provider.dart';
import 'package:shopappcourse/controllers/login_provider.dart';
import 'controllers/mainscreen_provider.dart';
import 'controllers/product_provider.dart';
import 'views/ui/mainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  HttpOverrides.global = MyHttpOverrides();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => FavoritesNotifier())),
    ChangeNotifierProvider(create: ((context) => MainScreenNotifier())),
    ChangeNotifierProvider(
      create: (context) => ProductNotifier(),
    ),
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => LoginNotifier(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: ((context, child) {
          return MaterialApp(
            title: 'Qua Dep Trai 77',
            theme: ThemeData(
                primaryColor: Colors.blue,
                scaffoldBackgroundColor: const Color(0xFFE2E2E2)),
            home: MainScreen(),
          );
        }));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
