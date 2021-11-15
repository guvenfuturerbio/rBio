import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../store/premium_store_page.dart';

class ShoppingCartHandler with ChangeNotifier {
  static final ShoppingCartHandler _instance = ShoppingCartHandler._internal();

  factory ShoppingCartHandler() {
    return _instance;
  }

  ShoppingCartHandler._internal() {
    _storePackages = [];
  }

  List<StorePackage> _storePackages;

  List<StorePackage> get storePackages => _storePackages;
  int get cartSize => _storePackages.length;

  void addToCart(StorePackage storePackage) {
    storePackages.add(storePackage);
    notifyListeners();
  }

  void removeFromCart(StorePackage storePackage) {
    storePackages.remove(storePackage); // Maybe remove with an index
    notifyListeners();
  }
}
