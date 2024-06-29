import 'package:careflix_parental_control/core/routing/route_path.dart';
import 'package:careflix_parental_control/layers/view/parental_control/block_show_category/block_screen.dart';
import 'package:careflix_parental_control/layers/view/parental_control/block_show_category/search_block_screen.dart';
import 'package:careflix_parental_control/layers/view/parental_control/duration_management/duration_management_screen.dart';
import 'package:careflix_parental_control/layers/view/parental_control/duration_management/duration_rule_creator.dart';
import 'package:careflix_parental_control/layers/view/parental_control/time_management_screen.dart';
import 'package:careflix_parental_control/layers/view/qr_code_scanner/qr_code_request.dart';
import 'package:careflix_parental_control/layers/view/qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../layers/view/intro/splash_screen.dart';
import '../../layers/view/parental_control/app_status_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.SplashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutePaths.QrCodeScanner:
        return MaterialPageRoute(builder: (_) => const QrCodeScanner());
      case RoutePaths.QrCodeRequest:
        return MaterialPageRoute(builder: (_) => QrCoderRequest());
      case RoutePaths.TimeManagementScreen:
        return MaterialPageRoute(builder: (_) => const TimeManagementScreen());
      case RoutePaths.DurationManagementScreen:
        return MaterialPageRoute(
            builder: (_) => const DurationManagementScreen());
      case RoutePaths.DurationRuleCreator:
        return MaterialPageRoute(builder: (_) => DurationRuleCreator());
      case RoutePaths.BlockScreen:
        return MaterialPageRoute(builder: (_) => BlockScreen());
      case RoutePaths.SearchBlockScreen:
        return MaterialPageRoute(builder: (_) => SearchBlockScreen());
      case RoutePaths.AppStatusScreen:
        return MaterialPageRoute(builder: (_) => AppStatusScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
                // child: Text('No route defined for ${settings.name}'),
                ),
          ),
        );
    }
  }
}
