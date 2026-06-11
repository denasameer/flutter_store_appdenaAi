import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

import 'home_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import 'account_screen.dart';

class MineScreen extends StatefulWidget {
  final String name;

  const MineScreen({super.key, required this.name});

  @override
  State<MineScreen> createState() => _MineScreenState();
}

class _MineScreenState extends State<MineScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(

      body: IndexedStack(
        index: index,
        children: [
          const HomeScreen(),
          const FavoritesScreen(),
          const CartScreen(),
          AccountScreen(userName: widget.name,),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),

        backgroundColor: const Color(0xFF2E3A59),
        selectedItemColor: const Color(0xFFC8A96A),
        unselectedItemColor: Colors.white70,

        type: BottomNavigationBarType.fixed,

        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "المفضلة",
          ),

          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),

                if (cart.cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cart.cartItems.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: "السلة",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "الحساب",
          ),
        ],
      ),
    );
  }
}