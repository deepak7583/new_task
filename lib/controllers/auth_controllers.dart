import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      _handleAuthError(e);
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      _handleAuthError(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void _handleAuthError(dynamic error) {
    String message;
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          message = 'The email address is badly formatted.';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'user-not-found':
          message = 'No user found for this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password provided.';
          break;
        case 'email-already-in-use':
          message = 'The email is already in use by another account.';
          break;
        case 'operation-not-allowed':
          message = 'This sign-in method is not allowed.';
          break;
        case 'weak-password':
          message = 'The password is too weak.';
          break;
        default:
          message = 'An unexpected error occurred. Please try again later.';
      }
    } else {
      message = 'An unknown error occurred. Please try again.';
    }
    Get.snackbar('Error', message);
  }
}
