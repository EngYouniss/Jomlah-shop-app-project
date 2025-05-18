import 'package:bazar_flow/helpers/internet_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkInternetConnection(context);
  }

  Future<void> checkInternetConnection(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    bool hasInternet = await InternetHelper.checkInternetConnectionState();

    if (hasInternet) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      bool isLogged = sharedPreferences.getBool("isLogged") ?? false;

      if (isLogged) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/no_connection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            SizedBox(height: 130),
            Image(
              image: AssetImage("assets/images/logo_baz.jpg"),
              width: 350,
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
