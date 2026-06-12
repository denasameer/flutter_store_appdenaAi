import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {

  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> favorites = [];

  // 🟢 مفاتيح التخزين
  String cartKey = "cart_data";
  String favKey = "favorites_data";

  // 🟢 constructor (تحميل البيانات عند فتح التطبيق)
  CartProvider() {
    loadCart();
    loadFavorites();
  }

  // =========================
  // 🟢 CART FUNCTIONS
  // =========================

  void addToCart(Map<String, dynamic> item) {
    int index = cartItems.indexWhere(
        (e) => e["name"] == item["name"]);

    if (index != -1) {
      cartItems[index]["qty"] += 1;
    } else {
      cartItems.add(item);
    }

    saveCart();
    notifyListeners();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);

    saveCart();
    notifyListeners();
  }

  void increaseQuantity(int index) {
    cartItems[index]["qty"] += 1;

    saveCart();
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index]["qty"] > 1) {
      cartItems[index]["qty"] -= 1;
    } else {
      cartItems.removeAt(index);
    }

    saveCart();
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

  // =========================
  // 🟢 FAVORITES FUNCTIONS
  // =========================

  void addToFavorites(Map<String, dynamic> item) {
    bool exists = favorites.any(
        (e) => e["name"] == item["name"]);

    if (!exists) {
      favorites.add(item);

      saveFavorites();
      notifyListeners();
    }
  }

  void removeFromFavorites(int index) {
    favorites.removeAt(index);

    saveFavorites();
    notifyListeners();
  }

  void removeFromFavoritesByName(String name) {
    favorites.removeWhere(
        (item) => item["name"] == name);

    saveFavorites();
    notifyListeners();
  }

  // =========================
  // 🟢 LOCAL STORAGE (SAVE)
  // =========================

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(
      cartKey,
      jsonEncode(cartItems),
    );
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(
      favKey,
      jsonEncode(favorites),
    );
  }

  // =========================
  // 🟢 LOCAL STORAGE (LOAD)
  // =========================

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(cartKey);

    if (data != null) {
      cartItems = List<Map<String, dynamic>>.from(
        jsonDecode(data),
      );
      notifyListeners();
    }
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(favKey);

    if (data != null) {
      favorites = List<Map<String, dynamic>>.from(
        jsonDecode(data),
      );
      notifyListeners();
    }
  }
}