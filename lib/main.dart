import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservation_app/core/utils/routes.dart';
import 'package:reservation_app/presentation/screens/main_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Reservations App',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white), useMaterial3: true, fontFamily: 'SF-Pro'),
        builder: (ctx, child) {
          ScreenUtil.init(ctx, designSize: const Size(375, 812));
          return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
        home: const MainScreen(),
        onGenerateRoute: (RouteSettings settings) => Routes(navigatorKey: navigatorKey).onGenerateRoute(settings));
  }
}
