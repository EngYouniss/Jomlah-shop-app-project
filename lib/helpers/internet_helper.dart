import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetHelper {
 static Future<bool> checkInternetConnectionState()async {
   return await InternetConnectionChecker.instance.hasConnection;
  }
}
