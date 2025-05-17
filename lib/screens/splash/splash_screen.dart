import 'dart:async';

import 'package:demaze_practical/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userEmail;
  bool? isLoggedIn = false;

  @override
  void initState() {
    getUserLoggedIn().whenComplete(
      () async {
        isLoggedIn == null || isLoggedIn == false
            ? Timer(const Duration(seconds: 5), () {
                context.pushNamed(
                  RouteNames.signInRoute,
                );
              })
            : Timer(const Duration(seconds: 5), () {
                context.pushNamed(RouteNames.tasksRoute);
              });
      },
    );
    super.initState();
  }

  //Gives User Preferences : User Logged in or Not
  Future getUserLoggedIn() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var isUserLogged = preferences.getBool("email");
    setState(() {
      isLoggedIn = isUserLogged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("lib/assets/demaze_logo.jpeg",
                width: 300, height: 300),
          ),
          const SizedBox(
            height: 30,
          ),
          Text("Demaze Technologies",
              style: GoogleFonts.poppins(fontSize: 30, color: Colors.purple))
        ],
      )),
    );
  }
}
