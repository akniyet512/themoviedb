import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';

abstract class MainNavigationRouteNames {
  static const String auth = "auth";
  static const String mainScreen = "/";
  static const String movieDetails = "/movie-details";
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;

  final Map<String, Widget Function(BuildContext)> routes = {
    MainNavigationRouteNames.auth: (context) => AuthProvider(
          model: AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRouteNames.mainScreen: (context) => const MainScreenWidget(),
  };

  Route<Object> onGenerateRoute(RouteSettings routeSettings) {
    final Map<String, dynamic> args =
        routeSettings.arguments as Map<String, dynamic>;
    switch (routeSettings.name) {
      case MainNavigationRouteNames.movieDetails:
        final int movieId = args["movieId"] is int ? args["movieId"] : 0;
        return MaterialPageRoute(
          builder: (context) => MovieDetailsWidget(movieId: movieId),
          settings: RouteSettings(name: "${routeSettings.name}/$movieId"),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Navigation error!"),
            ),
          ),
        );
    }
  }
}
