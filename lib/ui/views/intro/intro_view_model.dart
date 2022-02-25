
import 'package:flutter/material.dart';

import '../../../locator.dart';
import '../../../router.dart';
import '../../vgts_base_view_model.dart';


class IntroViewModel extends VGTSBaseViewModel {

  final PageController controller = PageController(initialPage: 0);

  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  set activeIndex(int value) {
    _activeIndex = value;
    notifyListeners();
  }

  @override
  Future onInit() async {
    return super.onInit();
  }

  onRegisterClick(){
    navigationService.pushNamed(Routes.register);
  }

  onLoginClick(){
    navigationService.pushNamed(Routes.logIn);
  }

}