import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {
  static Future<List<Product>> getProducts() async {
    final url = Uri.parse('https://dummyjson.com/products');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final List<dynamic> productsJson = data["products"];

        return productsJson
            .map((item) => Product.fromJson(item))
            .toList();
      } else {
        throw Exception("فشل تحميل المنتجات: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("خطأ في الاتصال: $e");
    }
  }
}