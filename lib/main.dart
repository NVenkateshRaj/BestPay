import 'dart:async';
import 'dart:io';
import 'package:bestpay/router.dart';
import 'package:bestpay/shared/database_service.dart';
import 'package:bestpay/shared/navigator_service.dart';
import 'package:bestpay/shared/network_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/res/styles.dart';
import 'locator.dart';

Future<Null> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runZoned<Future<void>>(() async {
    runApp(MyApp());
  }, onError: (Object obj, StackTrace stack) {});
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final navigationService = locator<NavigationService>();
  final databaseService = locator<DatabaseService>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:Platform.isIOS ? Brightness.light : Brightness.dark
    ));
    return MultiProvider(
      providers: [
        Provider<NetworkService>(create: (context) => locator<NetworkService>().init()),
      ],
      child: MaterialApp(
        title: "ATAPI",
        theme: AppStyle.appTheme,
        initialRoute:  '/',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigationService.navigatorKey,
        onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}

