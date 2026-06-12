import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

import 'providers/cart_provider.dart';
import 'auth/login_screen.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Noorden",
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF3F0E8),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2E3A59),
            foregroundColor: Colors.white,
          ),
        ),

        // 🟢 هنا أهم جزء (Firebase Auth Stream)
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // أثناء التحميل
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            // إذا المستخدم مسجل دخول → المتجر
            if (snapshot.hasData) {
              return const WelcomeScreen();
            }

            // إذا غير مسجل → تسجيل الدخول
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}