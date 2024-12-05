// ignore_for_file: constant_identifier_names, empty_constructor_bodies
import 'package:esight_app/utilities/colors.dart';
import 'package:esight_app/view/home_page.dart';
import 'package:esight_app/view/landing_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _customPageRoute(
              const LandingPage(),
            );
          case '/home':
            return _customPageRoute(
              const HomePage(),
            );

          default:
            return _customPageRoute(const LandingPage());
        }
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Pallete.backgroundColor,
        useMaterial3: true,
      ),
    );
  }

  PageRouteBuilder _customPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
