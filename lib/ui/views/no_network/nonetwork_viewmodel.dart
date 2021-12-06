import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';


class NoNetworkViewModel extends BaseViewModel{

  StreamSubscription<ConnectivityResult>? subscription;

  init(){
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
       if(result == ConnectivityResult.wifi || result == ConnectivityResult.wifi){
      navigationService.pop();
      }
    });
  }

}
