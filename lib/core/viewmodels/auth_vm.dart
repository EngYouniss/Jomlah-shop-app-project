import 'package:firebase_auth/firebase_auth.dart';

class AuthVM {
  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> loginByEmailAndBassowrd(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true; // ✅ تم تسجيل الدخول بنجاح
    } catch (e) {
      print('خطأ أثناء تسجيل الدخول: $e');
      return false; // ❌ فشل
    }
  }


  Future<bool> createUserAccount(String name, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      user = auth.currentUser;

      await user!.updateDisplayName(name);

      // يمكنك هنا تخزين معلومات المستخدم في Firestore إذا أردت.

      return true; // ✅ النجاح
    } catch (e) {
      print('حدث خطأ أثناء إنشاء الحساب: $e');
      return false; // ❌ فشل
    }
  }

  logout(){
    auth.signOut();
  }

}
