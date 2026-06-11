import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {

  List<Map<String, dynamic>> cartItems = [];

  List<Map<String, dynamic>> favorites = [];

  
  void addToCart(Map<String, dynamic> item) {
    int index = cartItems.indexWhere(
        (e) => e["name"] == item["name"]);

    if (index != -1) {
      cartItems[index]["qty"] += 1;
    } else {
      cartItems.add(item);
    }

    notifyListeners();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    notifyListeners();
  }

  void increaseQuantity(int index) {
    cartItems[index]["qty"] += 1;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index]["qty"] > 1) {
      cartItems[index]["qty"] -= 1;
    } else {
      cartItems.removeAt(index);
    }

    notifyListeners();
  }

  double get totalPrice {
    double total = 0;

    for (var item in cartItems) {
      total +=
          double.parse(item["price"].toString()) *
              item["qty"];
    }

    return total;
  }

 
  void addToFavorites(Map<String, dynamic> item) {
    bool exists = favorites.any(
        (e) => e["name"] == item["name"]);

    if (!exists) {
      favorites.add(item);
      notifyListeners();
    }
  }

  void removeFromFavorites(int index) {
    favorites.removeAt(index);
    notifyListeners();
  }

  void removeFromFavoritesByName(String name) {
    favorites.removeWhere(
        (item) => item["name"] == name);

    notifyListeners();
  }
}