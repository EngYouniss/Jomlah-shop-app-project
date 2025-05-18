import 'package:bazar_flow/core/viewmodels/cart_vm.dart';
import 'package:bazar_flow/core/views/screens/add_products_screen.dart';
import 'package:bazar_flow/core/views/screens/auth/login_screen.dart';
import 'package:bazar_flow/core/views/screens/auth/register_screen.dart';
import 'package:bazar_flow/core/views/screens/cart_screen.dart';
import 'package:bazar_flow/core/views/screens/home_screen.dart';
import 'package:bazar_flow/core/views/screens/no_connection.dart';
import 'package:bazar_flow/core/views/screens/products_screen.dart';
import 'package:bazar_flow/core/views/screens/splash_screen.dart';
import 'package:bazar_flow/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartVM()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(


        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      // home: HomeScreen(),
      initialRoute: "/splash",
      routes: {
        '/home':(context)=>HomeScreen(),
        'Products':(context)=>ProductsScreen(),
        '/splash':(context)=>SplashScreen(),
        '/no_connection':(context)=>NoConnection(),
        '/login':(context)=>LoginScreen(),
        '/register':(context)=>RegisterScreen(),
        '/add_product':(context)=>AddProductsScreen(),
        '/cart':(context)=>CartScreen(),
      },
    );
  }
}

