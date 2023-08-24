import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopappcourse/views/ui/favorites.dart';

import '../../controllers/mainscreen_provider.dart';
import '../shared/bottom_nav.dart';
import 'homepage.dart';
import 'profile.dart';
import 'searchpage.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const Favorites(),
    // CartPage(),
    const ProfilePage(),
  ];
  
  

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottoNavBar(),
        );
      },
    );
  }
}
