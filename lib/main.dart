import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';

import 'screens/welcome_screen.dart';

void main() {
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
          scaffoldBackgroundColor:
              const Color(0xFFF3F0E8),

          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2E3A59),
            foregroundColor: Colors.white,
          ),

          elevatedButtonTheme:
              ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFF2E3A59),
              foregroundColor: Colors.white,
            ),
          ),
        ),

        home: const WelcomeScreen(),
      ),
    );
  }
}