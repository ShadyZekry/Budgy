import 'package:budgy/main_router.gr.dart';
import 'package:flutter/material.dart';

// I'll leave it like that until I find a way to use it normally
final appRouter = AppRouter();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'BebasNeue-Regular',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
