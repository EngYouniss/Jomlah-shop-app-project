import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthVM {
  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> loginByEmailAndBassowrd(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print('خطأ أثناء تسجيل الدخول: $e');
      return false;
    }
  }


  Future<bool> createUserAccount(String name, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      user = auth.currentUser;
      await user!.updateDisplayName(name);
      return true;
    } catch (e) {
      print('حدث خطأ أثناء إنشاء الحساب: $e');
      return false;
    }
  }

  logout()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
sharedPreferences.remove("isLogged");
    auth.signOut();
  }

}
