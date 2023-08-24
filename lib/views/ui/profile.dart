import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopappcourse/services/authhelper.dart';
import 'package:shopappcourse/views/ui/nonuser.dart';
import '../../controllers/login_provider.dart';
import '../shared/appstyle.dart';
import '../shared/resusable_text.dart';
import '../shared/tiles_widget.dart';
import 'auth/login.dart';
import 'cartpage.dart';
import 'favorites.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    // authNotifier.getPrefs();
    return authNotifier.loggeIn == false
        ? const NonUser()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFE2E2E2),
              elevation: 0,
              leading: const Icon(
                MaterialCommunityIcons.qrcode_scan,
                size: 18,
                color: Colors.black,
              ),
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/usa.svg",
                          width: 15.w,
                          height: 25,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(height: 15.h, width: 1.w, color: Colors.grey),
                        reusableText(
                            text: " VietNam",
                            style:
                                appstyle(16, Colors.black, FontWeight.normal)),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(
                            SimpleLineIcons.settings,
                            color: Colors.black,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 750.h,
                    decoration: const BoxDecoration(color: Color(0xFFE2E2E2)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 16, 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 35.h,
                                      width: 35.w,
                                      child: const CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/user.jpg")),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    FutureBuilder(
                                        future: AuthHelper().getProfile(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: reusableText(
                                                  text: "Error get you data",
                                                  style: appstyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w600)),
                                            );
                                          } else {
                                            final userData = snapshot.data;
                                            return SizedBox(
                                              height: 35.h,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  reusableText(
                                                      text:
                                                          userData?.username ??
                                                              "",
                                                      style: appstyle(
                                                          12,
                                                          Colors.black,
                                                          FontWeight.normal)),
                                                  reusableText(
                                                      text:
                                                          userData?.email ?? "",
                                                      style: appstyle(
                                                          12,
                                                          Colors.black,
                                                          FontWeight.normal)),
                                                ],
                                              ),
                                            );
                                          }
                                        }),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Feather.edit,
                                        size: 18,
                                      )),
                                )
                              ]),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              height: 160.h,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TilesWidget(
                                      OnTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      },
                                      title: "My Orders",
                                      leading: MaterialCommunityIcons
                                          .truck_check_outline),
                                  TilesWidget(
                                      OnTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Favorites()));
                                      },
                                      title: "My Favorites",
                                      leading:
                                          MaterialCommunityIcons.heart_outline),
                                  TilesWidget(
                                      OnTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CartPage()));
                                      },
                                      title: "Cart",
                                      leading: Fontisto.shopping_bag_1),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 100.h,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TilesWidget(
                                      OnTap: () {},
                                      title: "Coupons",
                                      leading:
                                          MaterialCommunityIcons.tag_faces),
                                  TilesWidget(
                                      OnTap: () {},
                                      title: "My Store",
                                      leading:
                                          MaterialCommunityIcons.store_24_hour),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 160.h,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TilesWidget(
                                      OnTap: () {},
                                      title: "Shipping address",
                                      leading: SimpleLineIcons.location_pin),
                                  TilesWidget(
                                      OnTap: () {},
                                      title: "Settings",
                                      leading: AntDesign.setting),
                                  TilesWidget(
                                      OnTap: () {
                                        authNotifier.logout();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    LoginPage())));
                                      },
                                      title: "Logout",
                                      leading: AntDesign.logout),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
