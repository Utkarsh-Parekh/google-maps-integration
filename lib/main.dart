import 'package:demaze_practical/core/provider/theme_provider.dart';
import 'package:demaze_practical/core/routes/app_routes.dart';
import 'package:demaze_practical/core/services/notification_services.dart';
import 'package:demaze_practical/core/themes/app_theme.dart';
import 'package:demaze_practical/firebase_options.dart';
import 'package:demaze_practical/screens/maps/bloc/address-bloc/address_bloc.dart';
import 'package:demaze_practical/screens/maps/bloc/address-bloc/address_event.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_bloc.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_event.dart';
import 'package:demaze_practical/screens/profile/provider/image_provider.dart';
import 'package:demaze_practical/screens/tasks/bloc/task_bloc.dart';
import 'package:demaze_practical/screens/tasks/bloc/task_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'screens/maps/bloc/location-bloc/location_bloc.dart';

void main() async{
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  FlutterNativeSplash.remove();

  await NotificationServices().initializeNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImagePickerProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        BlocProvider(
          create: (context) => LocationBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc()..add(FetchProfileDetails()),
        ),
        BlocProvider(create: (context) => TaskBloc()..add(FetchTasks())),
        BlocProvider(create: (context) => AddressBloc()..add(FetchSavedAddresses()))

      ],
      child: const MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context,themeprovider,child) => MaterialApp.router(
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        // themeMode:themeprovider.themedata
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.routes,
      ),
    );
  }
}
