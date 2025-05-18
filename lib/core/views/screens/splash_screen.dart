import 'package:bazar_flow/helpers/internet_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    checkInternetConnection(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 130,),
            Image.asset("assets/images/logo_baz.jpg",width: 350,),
            SizedBox(height: 50,),
            CircularProgressIndicator(),
          ],
        ),
      )
    );
  }
}

checkInternetConnection(BuildContext context)async{
   Future.delayed(Duration(seconds: 3),(){
     InternetHelper.checkInternetConnectionState().then((value) {
       if (value)
         Navigator.pushReplacementNamed(context, "/login");
       else
         Navigator.pushReplacementNamed(context, "/no_connection");
     });
   });
}