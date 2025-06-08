import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantshop_app_admin/add_plant.dart';
import 'package:plantshop_app_admin/admin_login_screen.dart';
import 'package:plantshop_app_admin/dashboard.dart';
import 'package:plantshop_app_admin/products.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const AdminLoginScreen(),
  ),
  GoRoute(
    path: '/dashboard',
    builder: (context, state) => const Dashboard(),
  ),
  GoRoute(
    path: '/products',
    builder: (context, state) => const Products(),
    routes: [
      GoRoute(
        path: 'add-product',
        builder: (context, state) => const AddPlant(),
      )
    ],
  )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _router,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 130, 170, 87),
          primary: const Color.fromARGB(255, 129, 163, 71),
          secondary: const Color.fromARGB(255, 87, 111, 68),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w200,
          ),
          titleMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        useMaterial3: true,
      ),
    );
  }
}
