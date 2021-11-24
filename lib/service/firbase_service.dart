import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final firebaseAuth = FirebaseAuth.instance;
  Future registerWithEmailAndPassword(email, password) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final activateUser = await result.user!.sendEmailVerification();
      final currentUser = firebaseAuth.currentUser;
      print("Current user: " + currentUser!.uid.toString());
      print("Check if current user's email is verified " +
          result.user!.emailVerified.toString());
      if (result.user!.emailVerified) {
        print("Verified email");
      } else {
        print("Un verified email");
      }
      print("====> SUCCEED Registration: ");
      print("====> " + result.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future loginWithEmail(email, password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // ignore: unnecessary_null_comparison
      if (userCredential.user!.uid != null) {
        print("Loin succeed with email: " +
            userCredential.user!.email.toString());
      } else {
        print("Fail loin");
      }
    } catch (e) {
      print("==> Login fail" + e.toString());
    }
  }
}
