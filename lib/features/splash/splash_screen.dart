import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sundari/common/widgets/bottom_bar.dart';
import 'package:sundari/features/admin/screens/admin_screen.dart';
import 'package:sundari/features/auth/screens/auth_screen.dart';
import 'package:sundari/features/auth/services/auth_service.dart';
import 'package:sundari/providers/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final AuthService authService = AuthService();
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animation = Tween(
      begin: -400.0,
      end: 710.0,
    ).animate(animationController);

    animationController.addListener(() {
      setState(() {
        
      });
    });

    animationController.forward();

    authService.getUserData(context);

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(
        context,
        Provider.of<UserProvider>(context, listen: false).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context, listen: false).user.type ==
                    'user'
                ? BottomBar.routeName
                : AdminScreen.routeName
            : AuthScreen.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/latest_background.webp',
              fit: BoxFit.fitHeight,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              left: animation.value,
              top: 500,
              child: Image.asset('assets/images/welcome.png'),
            ),
            Positioned(
              left: 50,
              top: 150,
              child: Image.asset(
                'assets/images/main_logo_bg.png',
                height: 310,
                width: 310,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
