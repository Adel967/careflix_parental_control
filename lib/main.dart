import 'package:careflix_parental_control/core/app/state/app_state.dart';
import 'package:careflix_parental_control/core/shared_preferences/shared_preferences_instance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/configuration/styles.dart';
import 'core/routing/route_path.dart';
import 'core/routing/router.dart';
import 'core/services/assets_loader.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'injection_container.dart';
import 'l10n/l10n.dart';
import 'l10n/local_provider.dart';

void main() async {
  initInjection();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesInstance().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AssetsLoader.initAssetsLoaders();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<LocaleProvider>()),
        ChangeNotifierProvider(create: (context) => sl<AppState>()),
      ],
      builder: (context, state) {
        final localizationProvider = Provider.of<LocaleProvider>(context);

        return ScreenUtilInit(
          designSize: Size(1080, 1920),
          minTextAdapt: true,
          useInheritedMediaQuery: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Styles.colorPrimary, brightness: Brightness.dark),
              useMaterial3: true,
              iconTheme: IconThemeData(color: Colors.white),
              appBarTheme: AppBarTheme(backgroundColor: Styles.backgroundColor),
              scaffoldBackgroundColor: Styles.backgroundColor,
              inputDecorationTheme: Styles.inputDecorationStyle
                  .copyWith(fillColor: Styles.backgroundColor),
            ),
            supportedLocales: L10n.all,
            locale: localizationProvider.locale,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: RoutePaths.SplashScreen,
          ),
        );
      },
    );
  }
}
