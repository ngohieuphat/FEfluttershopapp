import 'package:flutter/material.dart';
import 'package:shopappcourse/models/sneaker_model.dart';
import 'package:shopappcourse/services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];

  int get activepage => _activepage;

  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoeSizes;
  set shoeSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        _shoeSizes[i]['isSelected'] = !_shoeSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;
  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

   Future<List<Sneakers>> male = Future.value([]);
   Future<List<Sneakers>> female = Future.value([]);
   Future<List<Sneakers>> kid = Future.value([]);
   Future<Sneakers> sneaker = Future.value(Sneakers(imageUrl: [], sizes: []));

  void getMale()  {
    male =  Helper().getMaleSneakers();
  }

  void getFemale() {
    female = Helper().getFemaleSneakers();
  }

  void getkid() {
    kid = Helper().getKidsSneakers();
  }

  // void getShoes(String category , String id) {
  //   if (category == "Men's Running") {
  //     sneaker = Helper().getMaleSneakersById(id);
  //   } else if (category == "Women's Running") {
  //     sneaker = Helper().getFemaleSneakersById(id);
  //   } else {
  //     sneaker = Helper().getKidSneakersById(id);
  //   }
  // }
}
