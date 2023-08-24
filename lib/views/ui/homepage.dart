import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopappcourse/controllers/login_provider.dart';
import 'package:shopappcourse/views/shared/resusable_text.dart';
import '../../controllers/favorites_provider.dart';
import '../../controllers/product_provider.dart';

import '../shared/appstyle.dart';
import '../shared/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();

    final productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    final favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: false);
    final authNotifier = Provider.of<LoginNotifier>(context, listen: false);

    productNotifier.getFemale();
    productNotifier.getMale();
    productNotifier.getkid();

    favoritesNotifier.getFavorites();

    authNotifier.getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: 812.h,
        width: 375.w,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
              height: 325.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.jpeg"),
                    fit: BoxFit.fill),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 8.w, bottom: 15.h),
                width: 375.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    reusableText(
                      text: "Athletics Shoes",
                      style: appstyleWithHt(
                          42, Colors.black, FontWeight.bold, 1.5),
                    ),
                    reusableText(
                      text: "Collection",
                      style: appstyleWithHt(
                          42, Colors.black, FontWeight.bold, 1.2),
                    ),
                    TabBar(
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.black,
                      labelStyle: appstyle(24, Colors.white, FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(0.3),
                      tabs: const [
                        Tab(
                          text: "Men Shoes",
                        ),
                        Tab(
                          text: "Women Shoes",
                        ),
                        Tab(
                          text: "Kids Shoes",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 203.h),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(
                      male: productNotifier.male,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      male: productNotifier.female,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      male: productNotifier.kid,
                      tabIndex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
