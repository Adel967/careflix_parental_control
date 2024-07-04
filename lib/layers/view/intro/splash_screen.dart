import 'dart:io';
import 'package:careflix_parental_control/core/routing/route_path.dart';
import 'package:careflix_parental_control/layers/data/repository/connection_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app/state/app_state.dart';
import '../../../core/configuration/assets.dart';
import '../../../core/configuration/styles.dart';
import '../../../core/constants.dart';
import '../../../core/shared_preferences/shared_preferences_instance.dart';
import '../../../core/shared_preferences/shared_preferences_key.dart';
import '../../../core/utils/size_config.dart';
import '../../../injection_container.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundAnimationController;
  late AnimationController _textAnimationController;
  late AnimationController _controller;
  late AnimationController _imageAnimation;
  late Animation<Color?> _animationColorBg;
  late Animation<int> _characterCount;
  late Animation<double> _imageHeight;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _navigateAfterDelay();
  }

  void _initializeBackgroundAnimation() {
    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationColorBg = ColorTween(
      begin: Styles.colorPrimary,
      end: Styles.backgroundColor,
    ).animate(_backgroundAnimationController);
  }

  void _initializeTextAnimation() {
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _characterCount = StepTween(begin: 0, end: Constants.appName.length)
        .animate(CurvedAnimation(
            parent: _textAnimationController, curve: Curves.easeIn));
  }

  void _initializeImageAnimation() {
    _imageAnimation = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _imageHeight = new Tween(begin: 130.0, end: 40.0).animate(_imageAnimation);
  }

  void _initializeAnimation() async {
    _initializeBackgroundAnimation();
    _initializeTextAnimation();
    _initializeImageAnimation();

    _backgroundAnimationController.forward();

    _backgroundAnimationController.addListener(() {
      setState(() {});
    });

    _backgroundAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _imageAnimation.forward();
      }
    });

    _imageHeight.addListener(() {
      setState(() {});
    });

    _controller = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _textAnimationController.forward();
        }
      });
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 4));

    final userId = await SharedPreferencesInstance.pref
        .getString(SharedPreferencesKeys.UserId);
    if (userId != null) {
      await Provider.of<AppState>(context, listen: false).init();

      Navigator.of(context).pushNamedAndRemoveUntil(
          RoutePaths.TimeManagementScreen, (route) => false);
    } else {
      Navigator.of(context).pushReplacementNamed(RoutePaths.QrCodeRequest);
    }
  }

  void _navigateTo(String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: _animationColorBg.value,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  height: _imageHeight.value,
                  AssetsLink.APP_LOGO,
                ),
                CommonSizes.hSmallSpace,
                Container(
                  color: Colors.white,
                  height: 20,
                  width: 2,
                ).animate(controller: _controller).scaleY(
                    delay: Duration(milliseconds: 1400),
                    duration: Duration(milliseconds: 300),
                    begin: 0,
                    end: 1.5),
                CommonSizes.hSmallSpace,
                _characterCount == null
                    ? SizedBox()
                    : AnimatedBuilder(
                        animation: _characterCount,
                        builder: (context, child) {
                          String text = Constants.appName
                              .substring(0, _characterCount.value);
                          return Text(
                            text,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          );
                        },
                      )
              ],
            ),
            CommonSizes.vSmallSpace,
            Text("Where Entertainment Meets Safety")
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 2600),
                  duration: Duration(milliseconds: 500),
                )
                .slideY(
                    delay: Duration(milliseconds: 2600),
                    duration: Duration(milliseconds: 700),
                    begin: 0.5,
                    end: 0)
          ],
        ),
      ),
    );
  }
}
