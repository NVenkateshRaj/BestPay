import 'package:bestpay/shared/network_service.dart';

import '../../../locator.dart';
import '../../../router.dart';
import '../../vgts_base_view_model.dart';

class SplashViewModel extends VGTSBaseViewModel {

  @override
  Future onInit() async {
    await preferenceService.init();
    await locator<NetworkService>().init();
    try {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (preferenceService.getBearerToken().isNotEmpty) {
          navigationService.popAllAndPushNamed(Routes.dashboard);
        } else {
          navigationService.popAllAndPushNamed(Routes.logIn);
        }
      });

    } catch (ex) {
      print("EXCEPTION $ex");
    }

    return super.onInit();
  }

}