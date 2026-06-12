import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF2E3A59),
        title: const Text(
          "المفضلة ❤️",
          style: TextStyle(color: Color(0xFFC8A96A)),
        ),
      ),

      body: provider.favorites.isEmpty
          ? const Center(
              child: Text(
                "لا توجد عناصر في المفضلة",
                style: TextStyle(color: Color(0xFFC8A96A)),
              ),
            )
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final item = provider.favorites[index];

                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1C),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xFFC8A96A)),
                  ),
                  child: Row(
                    children: [
                      // 🟢 صورة API (تم التصحيح هنا)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: item["img"] != null
                            ? Image.network(
                                item["img"],
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"] ?? "",
                              style: const TextStyle(
                                color: Color(0xFFC8A96A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${item["price"] ?? "0"} ريال",
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        color: const Color(0xFFC8A96A),
                        onPressed: () {
                          provider.addToCart({
                            "name": item["name"],
                            "price": item["price"],
                            "qty": 1,
                            "img": item["img"], // مهم
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تمت الإضافة للسلة 🛒"),
                            ),
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          provider.removeFromFavorites(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}