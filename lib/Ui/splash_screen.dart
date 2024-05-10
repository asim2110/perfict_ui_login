import 'package:flutter/material.dart';
import 'package:perfict_ui_login/firebase_services/splash_servics.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    splashScreen.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Center(
            child: Text(
          "Splash Screen",
          style: TextStyle(fontSize: 30),
        )),
      ),
    );
  }
}
