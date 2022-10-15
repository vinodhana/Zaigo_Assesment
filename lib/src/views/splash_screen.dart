import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_videos/src/ui_utils/app_assets.dart';
import 'package:flutter_videos/src/utils/app_preferences.dart';
import 'package:flutter_videos/src/views/home_screen.dart';
import 'package:flutter_videos/src/views/login_screen.dart';
import 'package:flutter_videos/src/views/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      goToNext(context);
    });
  }

  goToNext(BuildContext context) async {
    bool isLogin = await AppPreferences.getLoginStatus();
    if (isLogin) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAssets.welcome), fit: BoxFit.fill),
            ),
            child:
                const SizedBox(), //const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
