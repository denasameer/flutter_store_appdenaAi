import 'package:flutter/material.dart';
import 'products_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> categories = const [
    {"name": "عالم رمضان", "image": "assets/images/foto2p.jpg"},
    {"name": "الحج", "image": "assets/images/foto3p.jpg"},
    {"name": "القرآن", "image": "assets/images/foto4p.jpg"},
    {"name": "الديكور", "image": "assets/images/foto5p.jpg"},
    {"name": "الصلاة", "image": "assets/images/foto6p.jpg"},
    {"name": "الكتب", "image": "assets/images/foto7p.jpg"},
    {"name": "الهدايا", "image": "assets/images/foto8p.jpg"},
    {"name": "الأناقة", "image": "assets/images/foto9p.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2E3A59),

        title: const Text(
          "Noorden",
          style: TextStyle(
            color: Color(0xFFC8A96A),
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: Column(
        children: [

          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/foto1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),

              itemBuilder: (context, i) {
                final item = categories[i];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsScreen(
                          category: item["name"]!,
                        ),
                      ),
                    );
                  },

                  child: Card(
                    color: const Color(0xFF1C1C1C), 
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.asset(
                              item["image"]!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            item["name"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC8A96A), 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}