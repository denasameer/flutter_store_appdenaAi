import 'package:flutter/material.dart';
import 'mine_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController nameController = TextEditingController();
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1E7),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Noorden ✨",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E3A59),
              ),
            ),

            const SizedBox(height: 40),

            TextField(
              controller: nameController,
              onChanged: (value) {
                setState(() {
                  isActive = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                hintText: "ادخل اسمك",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: isActive
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              MineScreen(name: nameController.text),
                        ),
                      );
                    }
                  : null,

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3A59),
                minimumSize: const Size(double.infinity, 55),
              ),

              child: const Text("دخول"),
            ),
          ],
        ),
      ),
    );
  }
}