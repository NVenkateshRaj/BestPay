
import 'dart:async';


import 'package:connectivity/connectivity.dart';


import '../../locator.dart';
import '../../router.dart';
import 'navigator_service.dart';

class NetworkService {
  StreamSubscription<ConnectivityResult>? subscription;
  init(){
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        navigationService.pushNamed(Routes.no_network);
      }
    });
  }
}