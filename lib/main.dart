import 'package:celebrare/src/core/constants/colors.dart';
import 'package:flutter/services.dart';
import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'celebrare_app.dart';

Future<void> main() async {
  //  ensure the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  //  Set color of status bar
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColor.shadeTeal,
      statusBarIconBrightness: Brightness.light,
    ),
  );
//  Here we are calling the Dependency Injection
  await DependencyInjection.init();

  //  This is the main app

  runApp(const CelebrareApp());
}
