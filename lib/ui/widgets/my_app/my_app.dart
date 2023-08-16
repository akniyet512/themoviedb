import 'package:flutter/material.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/widgets/my_app/my_app_model.dart';

class MyApp extends StatelessWidget {
  final MyAppModel myAppModel;

  const MyApp({
    super.key,
    required this.myAppModel,
  });

  static final MainNavigation _mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainDarkBlue,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainDarkBlue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      routes: _mainNavigation.routes,
      initialRoute: _mainNavigation.initialRoute(myAppModel.isAuth),
      onGenerateRoute: _mainNavigation.onGenerateRoute,
    );
  }
}
