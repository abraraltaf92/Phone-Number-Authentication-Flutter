import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hort_demo/checks/wrapper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // streams authentication state change of a user
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  // registering a user with email & password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return user;
    } catch (err) {
      print('Error while signing in : ${err.toString()}');
      return null;
    }
  }

  // signing in a user with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return user;
    } catch (e) {
      print('Error while signing in : ${e.toString()}');
      return null;
    }
  }

  // signout
  Future signOut() async {
    try {
      await _auth.signOut();
      Get.offAll(Wrapper());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future deleteUserAccount() async {
    User user = _auth.currentUser;
    await user.delete();
  }
}
