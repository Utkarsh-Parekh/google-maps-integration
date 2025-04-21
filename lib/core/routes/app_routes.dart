import 'package:demaze_practical/core/routes/route_names.dart';
import 'package:demaze_practical/screens/authentication/screens/password_recovery.dart';
import 'package:demaze_practical/screens/authentication/screens/signin_screen.dart';
import 'package:demaze_practical/screens/authentication/screens/signup_screen.dart';
import 'package:demaze_practical/screens/home/home_screen.dart';
import 'package:demaze_practical/screens/maps/screens/address_details.dart';
import 'package:demaze_practical/screens/maps/screens/maps_screen.dart';
import 'package:demaze_practical/screens/profile/screens/more_screen.dart';
import 'package:demaze_practical/screens/splash/splash_screen.dart';
import 'package:demaze_practical/screens/tasks/screens/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/profile/screens/update_profile.dart';

class AppRoutes {
  AppRoutes._();

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  static final _navigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: "shellHome");


  static final _navigatorMapsKey =
      GlobalKey<NavigatorState>(debugLabel: "shellMaps");

  static final _navigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: "shellProfile");

  static final GoRouter routes = GoRouter(
    initialLocation: "/splash",
    navigatorKey: _navigatorKey,

    routes: [


      //Splash Screen Route
      GoRoute(
        path: "/splash",
        name: RouteNames.initialRoute,
        builder: (context, state) {
          return SplashScreen(
            key: state.pageKey,
          );
        },
      ),

          //Sign Up screen Route
          GoRoute(
            path: "/signup",
            name: RouteNames.signUpRoute,
            builder: (context, state) {
              return SignUpPage(
                key: state.pageKey,
              );
            },
          ),

          //Sign In screen Route
          GoRoute(
            path: "/signIn",
            name: RouteNames.signInRoute,
            builder: (context, state) {
              return SignInPage(
                key: state.pageKey,
              );
            },
          ),

          //Password Recovery Route
          GoRoute(
            path: "/passwordRecovery",
            name: RouteNames.passwordRecoveryRoute,
            builder: (context, state) {
              return PasswordRecovery(
                key: state.pageKey,
              );
            },
          ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [

          //Tasks Screen route
          StatefulShellBranch(
            navigatorKey: _navigatorHomeKey,
            routes: [
              GoRoute(
                path: "/tasks",
                name: RouteNames.tasksRoute,
                builder: (context, state) {
                  return TasksScreen(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),

          //Maps Screen route
          StatefulShellBranch(
            navigatorKey: _navigatorMapsKey,
            routes: [
              GoRoute(
                path: "/maps",
                name: RouteNames.mapsRoute,
                builder: (context, state) {
                  return MapsScreen(
                    key: state.pageKey,
                  );
                },
              ),

              //Address Change Route
              GoRoute(
                path: "/changeAddress",
                name: RouteNames.addressRoute,
                pageBuilder: (context, state) {
                  return const MaterialPage(child: AddressDetails());
                },
              )
            ],
          ),

          //Profile Route
          StatefulShellBranch(
            navigatorKey: _navigatorProfileKey,
            routes: [
              GoRoute(
                  path: "/more",
                  name: RouteNames.moreRoute,
                  builder: (context, state) {
                    return MoreScreen(
                      key: state.pageKey,
                    );
                  }),
              GoRoute(
                path: "/updateprofile",
                name: RouteNames.updateRoute,
                pageBuilder: (context, state) {
                  return const MaterialPage(child: UpdateProfile());
                },
              ),
            ],
          )
        ],
      ),
    ],
  );
}
