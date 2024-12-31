import 'package:celebrare/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'src/core/routes/routes.dart';

class CelebrareApp extends StatelessWidget {
  const CelebrareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.initial,
      onGenerateRoute: AppRoute.generate,
    );
  }
}
