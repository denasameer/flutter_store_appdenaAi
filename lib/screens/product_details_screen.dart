import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartProvider>(context);

    final isFav = cart.favorites.any(
      (item) => item["name"] == widget.product.title,
    );

    final alreadyInCart = cart.cartItems.any(
      (item) => item["name"] == widget.product.title,
    );

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF2E3A59),
        title: Text(
          widget.product.title,
          style: const TextStyle(
            color: Color(0xFFC8A96A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// صورة المنتج
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(widget.product.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// الاسم
            Text(
              widget.product.title,
              style: const TextStyle(
                color: Color(0xFFC8A96A),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            /// السعر
            Text(
              "السعر: ${widget.product.price.toString()} ريال",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            /// الوصف
            Text(
              widget.product.description,
              style: const TextStyle(
                color: Colors.white54,
                height: 1.5,
              ),
            ),

            const Spacer(),

            /// الأزرار
            Row(
              children: [

                /// ⭐ المفضلة
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {

                      final isExist = cart.favorites.any(
                        (item) => item["name"] == widget.product.title,
                      );

                      if (isExist) {
                        cart.removeFromFavoritesByName(widget.product.title);
                      } else {
                        cart.addToFavorites({
                          "name": widget.product.title,
                          "img": widget.product.thumbnail,
                          "price": widget.product.price.toString(),
                        });
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isExist
                                ? "تم الحذف من المفضلة"
                                : "تمت الإضافة للمفضلة ❤️",
                          ),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFav
                          ? Colors.red
                          : const Color(0xFF2E3A59),
                      padding: const EdgeInsets.all(14),
                    ),

                    icon: Icon(
                      isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                    ),

                    label: const Text(
                      "المفضلة",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                /// 🛒 السلة
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {

                      final exists = cart.cartItems.any(
                        (item) => item["name"] == widget.product.title,
                      );

                      if (!exists) {
                        cart.addToCart({
                          "name": widget.product.title,
                          "img": widget.product.thumbnail,
                          "price": widget.product.price.toString(),
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
                            content: Text("المنتج موجود بالفعل في السلة"),
                          ),
                        );
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: alreadyInCart
                          ? const Color(0xFF8B5A2B)
                          : const Color(0xFF2E3A59),
                      padding: const EdgeInsets.all(14),
                    ),

                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),

                    label: const Text(
                      "السلة",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}