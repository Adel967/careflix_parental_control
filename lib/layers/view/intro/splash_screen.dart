import 'dart:io';
import 'package:careflix_parental_control/core/routing/route_path.dart';
import 'package:careflix_parental_control/layers/data/repository/connection_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app/state/app_state.dart';
import '../../../core/configuration/assets.dart';
import '../../../core/configuration/styles.dart';
import '../../../core/shared_preferences/shared_preferences_instance.dart';
import '../../../core/shared_preferences/shared_preferences_key.dart';
import '../../../core/utils/size_config.dart';
import '../../../injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _navigateAfterDelay();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = ColorTween(
      begin: Styles.colorPrimary,
      end: Styles.backgroundColor,
    ).animate(_animationController);

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));

    final userId = await SharedPreferencesInstance.pref
        .getString(SharedPreferencesKeys.UserId);
    if (userId != null) {
      await Provider.of<AppState>(context, listen: false).init();

      Navigator.of(context).pushNamedAndRemoveUntil(
          RoutePaths.TimeManagementScreen, (route) => false);
    } else {
      Navigator.of(context).pushReplacementNamed(RoutePaths.QrCodeRequest);
    }
    // User? user = FirebaseAuth.instance.currentUser;
    //
    // if (user != null) {
    //   _navigateBasedOnUserProfile(user);
    // } else {
    //   _navigateBasedOnFirstTime();
    // }
  }

  // void _navigateBasedOnUserProfile(User user) async {
  //   if (user.displayName != null && user.displayName!.isNotEmpty) {
  //     await Provider.of<AppState>(context, listen: false).init();
  //     _navigateTo(RoutePaths.Home);
  //   } else {
  //     _navigateTo(RoutePaths.SetUpProfileScreen);
  //   }
  // }
  //
  // void _navigateBasedOnFirstTime() {
  //   bool? isFirstTime = SharedPreferencesInstance.pref
  //       .getBool(SharedPreferencesKeys.FIRST_TIME_KEY);
  //
  //   if (isFirstTime == null || isFirstTime) {
  //     _navigateTo(RoutePaths.OnBoardingScreen);
  //   } else {
  //     _navigateTo(RoutePaths.LogIn);
  //   }
  // }

  void _navigateTo(String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: _animation.value,
      body: Center(
        child: Image.asset(AssetsLink.APP_LOGO),
      ),
    );
  }
}
