import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sundari/constants/global_variables.dart';
import 'package:sundari/constants/notification_service.dart';
import 'package:sundari/features/auth/services/auth_service.dart';
import 'package:sundari/features/splash/splash_screen.dart';
import 'package:sundari/providers/user_provider.dart';
import 'package:sundari/router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  NotificationsServices notificationsServices = NotificationsServices();
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();

    notificationsServices.initialiseNotifications();

    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const SplashScreen(),
    );
  }
}
