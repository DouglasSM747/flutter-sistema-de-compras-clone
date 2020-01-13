import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update the username
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.user.reload();
    return currentUser.user.uid;
  }

  // Email & Password Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    //trim retorna uma nova string sem espacos em branco a direita ou esquerda
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email.trim(), password: password.trim()))
        .user
        .uid;
  }

  someMethod() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.email);
  }

  // Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }
}
