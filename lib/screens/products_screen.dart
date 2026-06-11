import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../services/api_service.dart';
import '../models/product.dart';

import 'product_details_screen.dart';
import 'mine_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import 'account_screen.dart';

class ProductsScreen extends StatefulWidget {
  final String category;

  const ProductsScreen({super.key, required this.category});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  int currentIndex = 0;

  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = ApiService.getProducts();
  }

  void navigate(int index) {
    Widget page;

    switch (index) {
      case 0:
        page = const MineScreen(name: "المستخدم");
        break;

      case 1:
        page = const FavoritesScreen();
        break;

      case 2:
        page = const CartScreen();
        break;

      default:
        page = const AccountScreen(userName: "المستخدم");
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3A59),
        centerTitle: true,
        title: Text(widget.category),
      ),

      body: FutureBuilder<List<Product>>(
        future: productsFuture,

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFC8A96A),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "حدث خطأ في تحميل البيانات",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(
              child: Text(
                "لا توجد منتجات",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: products.length,

            itemBuilder: (context, i) {

              final item = products[i];

              final isFav = cart.favorites.any(
                (e) => e["name"] == item.title,
              );

              final existsInCart = cart.cartItems.any(
                (e) => e["name"] == item.title,
              );

              return GestureDetector(

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(
                        product: item,
                      ),
                    ),
                  );
                },

                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1C),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFFC8A96A),
                    ),
                  ),

                  child: Row(
                    children: [

                      /// صورة المنتج
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(item.thumbnail),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      /// الاسم
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            color: Color(0xFFC8A96A),
                            fontSize: 16,
                          ),
                        ),
                      ),

                      /// المفضلة
                      IconButton(
                        icon: Icon(
                          isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        color: Colors.red,

                        onPressed: () {
                          if (isFav) {
                            cart.removeFromFavoritesByName(item.title);
                          } else {
                            cart.addToFavorites({
                              "name": item.title,
                              "img": item.thumbnail,
                              "price": item.price.toString(),
                            });
                          }
                        },
                      ),

                      /// السلة
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: existsInCart
                              ? Colors.green
                              : const Color(0xFFC8A96A),
                        ),

                        onPressed: () {

                          if (!existsInCart) {
                            cart.addToCart({
                              "name": item.title,
                              "img": item.thumbnail,
                              "price": item.price.toString(),
                              "qty": 1,
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("تمت الإضافة للسلة 🛒"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("المنتج موجود بالفعل"),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: const Color(0xFF2E3A59),
        selectedItemColor: const Color(0xFFC8A96A),
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,

        onTap: navigate,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "المفضلة",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "السلة",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "الحساب",
          ),
        ],
      ),
    );
  }
}