import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {

  // Singleton Instance
  static final AuthService _instance = AuthService._internal();

  // Factory Constructor
  factory AuthService() => _instance;

  // Private Constructor
  AuthService._internal();


  //SIGN IN
  Future<void> signInUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      DelightToastBar(
        autoDismiss: true,
        snackbarDuration: Durations.extralong3,
        position: DelightSnackbarPosition.top,
        builder: (context) {
          return const ToastCard(
            color: Colors.green,
            leading: Icon(
              Icons.done,
              color: Colors.white,
            ),
            title: Text("Login Successfully"),
          );
        },
      ).show(context);

      //Navigation to Home Page
      context.go("/tasks");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DelightToastBar(
          autoDismiss: true,
          snackbarDuration: Durations.extralong3,
          position: DelightSnackbarPosition.top,
          builder: (context) {
            return const ToastCard(
              leading: Icon(
                Icons.notification_important,
                color: Colors.red,
              ),
              title: Text("User Not Found"),
            );
          },
        ).show(context);
        print("user not fouund");
      } else if (e.code == 'wrong-password') {
        DelightToastBar(
          autoDismiss: true,
          snackbarDuration: Durations.extralong3,
          position: DelightSnackbarPosition.top,
          builder: (context) {
            return const ToastCard(
                leading: Icon(
                  Icons.notification_important,
                  color: Colors.red,
                ),
                title: Text("Please enter Correct Password"));
          },
        ).show(context);
        print("wrong password");
      }
    }
  }


  //SIGN UP THE USER
  Future<void> signUpUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        DelightToastBar(
          autoDismiss: true,
          snackbarDuration: Durations.extralong3,
          position: DelightSnackbarPosition.top,
          builder: (context) {
            return const ToastCard(
              color: Colors.green,
              leading: Icon(
                Icons.done,
                color: Colors.white,
              ),
              title: Text("Registration Successfully"),
            );
          },
        ).show(context);

        //navigation to home page
        context.go('/tasks');

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DelightToastBar(
            autoDismiss: true,
            snackbarDuration: Durations.extralong3,
            position: DelightSnackbarPosition.top,
            builder: (context) {
              return const ToastCard(
                leading: Icon(
                  Icons.notification_important,
                  color: Colors.red,
                ),
                title: Text("Weak Password"),
              );
            },
          ).show(context);
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DelightToastBar(
            autoDismiss: true,
            snackbarDuration: Durations.extralong3,
            position: DelightSnackbarPosition.top,
            builder: (context) {
              return const ToastCard(
                leading: Icon(
                  Icons.notification_important,
                  color: Colors.red,
                ),
                title: Text("The account already exists for entered email"),
              );
            },
          ).show(context);
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }


  //FOR RESET PASSWORD
  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      DelightToastBar(
        autoDismiss: true,
        snackbarDuration: Durations.extralong3,
        position: DelightSnackbarPosition.top,
        builder: (context) {
          return const ToastCard(
            color: Colors.green,
            leading: Icon(
              Icons.done,
              color: Colors.white,
            ),
            title: Text("Email Reset Email send Successfully"),
          );
        },
      ).show(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        DelightToastBar(
          autoDismiss: true,
          snackbarDuration: Durations.extralong3,
          position: DelightSnackbarPosition.top,
          builder: (context) {
            return const ToastCard(
              leading: Icon(
                Icons.notification_important,
                color: Colors.red,
              ),
              title: Text("User Not Found"),
            );
          },
        ).show(context);
      }
    }
  }



  //SIGN OUT
  Future<void> signOut(BuildContext context) async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    prefs.setBool("email", false);
    await FirebaseAuth.instance.signOut();
    context.go('/signIn');
  }

}
