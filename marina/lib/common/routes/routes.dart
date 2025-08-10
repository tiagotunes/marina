import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marina/common/routes/routes_names.dart';
import 'package:marina/features/application/view/application.dart';
import 'package:marina/features/home/view/home.dart';
import 'package:marina/global.dart';
import 'package:marina/features/on_boarding/view/on_boarding.dart';
import 'package:marina/features/sign_in/view/sign_in.dart';
import 'package:marina/features/sign_up/view/sign_up.dart';
import 'package:marina/token_check.dart';

class Routes {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(path: RoutesNames.ON_BOARDING, page: OnBoarding()),
      RouteEntity(path: RoutesNames.SIGN_IN, page: SignIn()),
      RouteEntity(path: RoutesNames.SIGN_UP, page: SignUp()),
      RouteEntity(path: RoutesNames.APPLICATION, page: Application()),
      RouteEntity(path: RoutesNames.HOME, page: Home()),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      print("Route > ${settings.name}");
    }

    if (settings.name != null) {
      var result = routes().where((e) => e.path == settings.name);

      if (result.isNotEmpty) {
        bool appFirstTime = Global.storageService.getAppFirstTime();

        if (result.first.path == RoutesNames.ON_BOARDING && appFirstTime) {
          return MaterialPageRoute(
            builder: (_) => const TokenCheck(),
            settings: settings,
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => result.first.page,
            settings: settings,
          );
        }
      }
    }
    return MaterialPageRoute(builder: (_) => OnBoarding(), settings: settings);
  }
}

class RouteEntity {
  String path;
  Widget page;

  RouteEntity({required this.path, required this.page});
}
