import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/shared/preference_service.dart';
import 'package:stacked/stacked.dart';
import '../../locator.dart';
class VGTSBaseViewModel extends BaseViewModel {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  final PreferenceService preferenceService = locator<PreferenceService>();

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
  VGTSBaseViewModel() {
    this.onInit();
  }
  @override
  Future onInit() async {
    return true;
  }
  @override
  void dispose() {
    super.dispose();
  }
}
