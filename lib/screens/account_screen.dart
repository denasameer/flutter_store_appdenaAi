import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    super.initState();
    loadData();
  }

  // 🟢 تحميل البيانات
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    phoneController.text = prefs.getString("phone") ?? "";
    addressController.text = prefs.getString("address") ?? "";
  }

  // 🟢 حفظ البيانات
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("phone", phoneController.text);
    await prefs.setString("address", addressController.text);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم حفظ البيانات ✔")),
      );
    }
  }

  // 🟢 تسجيل خروج (الطريقة الصحيحة مع StreamBuilder)
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم تسجيل الخروج بنجاح 👋")),
      );
    }
  }

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

        // 🟢 زر تسجيل الخروج
        actions: [
          TextButton.icon(
            onPressed: logout,
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              "تسجيل خروج",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
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
                onPressed: saveData,
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