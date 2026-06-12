import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF2E3A59),
        title: const Text(
          "السلة 🛒",
          style: TextStyle(color: Color(0xFFC8A96A)),
        ),
      ),

      body: cart.cartItems.isEmpty
          ? const Center(
              child: Text(
                "السلة فارغة",
                style: TextStyle(
                  color: Color(0xFFC8A96A),
                  fontSize: 18,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];

                      return Container(
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
                            // 🟢 صورة API (تم التصحيح)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: item["img"] != null
                                  ? Image.network(
                                      item["img"],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          width: 70,
                                          height: 70,
                                          color: Colors.grey,
                                          child: const Icon(
                                            Icons.image_not_supported,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      width: 70,
                                      height: 70,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["name"] ?? "",
                                    style: const TextStyle(
                                      color: Color(0xFFC8A96A),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    "${item["price"] ?? 0} ريال",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 🟢 التحكم بالكمية
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cart.decreaseQuantity(index);
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),

                                Text(
                                  "${item["qty"]}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    cart.increaseQuantity(index);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                            IconButton(
                              onPressed: () {
                                cart.removeFromCart(index);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: const Color(0xFF2E3A59),
                  child: Text(
                    "المجموع: ${cart.totalPrice} ريال",
                    style: const TextStyle(
                      color: Color(0xFFC8A96A),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}