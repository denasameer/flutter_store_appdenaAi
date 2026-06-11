import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {

  final String userName;

  const AccountScreen({
    super.key,
    required this.userName,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF2E3A59),

        title: const Text(
          "الحساب",
          style: TextStyle(
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

            Text(
              "مرحبا ${widget.userName}",
              style: const TextStyle(
                color: Color(0xFFC8A96A),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: phoneController,
              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(
                labelText: "رقم الجوال",
                labelStyle: const TextStyle(color: Color(0xFFC8A96A)),

                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFC8A96A)),
                  borderRadius: BorderRadius.circular(12),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFC8A96A),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: addressController,
              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(
                labelText: "العنوان",
                labelStyle: const TextStyle(color: Color(0xFFC8A96A)),

                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFC8A96A)),
                  borderRadius: BorderRadius.circular(12),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFC8A96A),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("تم حفظ البيانات ✔"),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC8A96A),
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: const Text(
                  "حفظ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}