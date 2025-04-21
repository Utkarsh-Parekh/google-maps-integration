import 'package:demaze_practical/screens/authentication/constants/auth_constants.dart';
import 'package:demaze_practical/screens/authentication/services/auth_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool isValidEmail = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8A2BE2), // Blue Violet
                  Color(0xFF6A0DAD),],
                stops: [0.25, 0.75],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(AuthConstants.signInConst,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.white),
                      )),
                  Text(AuthConstants.signInCredentials,
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white)))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
                        onChanged: (emailValue) {
                          setState(() {

                            isValidEmail =
                                EmailValidator.validate(emailValue);
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AuthConstants.emptyEmailconst;
                          } else if (!isValidEmail) {
                            return AuthConstants.validEmailconst;
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: Color(0xff3f5efb),
                              fontWeight: FontWeight.bold),
                          hintText: AuthConstants.enterEmailconst,
                          suffixIcon: const Icon(Icons.done),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            // borderSide: const BorderSide(color: Colors.white70),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AuthConstants.passwordnotEmptyconst;
                          }
                        },
                        obscureText: !_passwordVisible,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: Color(0xff3f5efb),
                              fontWeight: FontWeight.bold),
                          hintText:AuthConstants.enterPasswordconst,
                          suffixIcon: IconButton(
                            icon: Icon(_passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          context.pushNamed("passwordRecovery");
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            AuthConstants.forgotpasswordconst,
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8A2BE2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              onPressed: () async {
                                if (_key.currentState!.validate()) {
                                  final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                                  prefs.setBool("email", true);
                                  AuthService().signInUserWithEmailAndPassword(
                                      context,
                                      emailController.text,
                                      passwordController.text);
                                }
                              },
                              child: Text(
                                AuthConstants.signInConst,
                                style: GoogleFonts.poppins(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AuthConstants.dontaccountconst,
                                style: GoogleFonts.poppins(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.go("/signup");
                                },
                                child: Text(
                                  AuthConstants.createconst,
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
