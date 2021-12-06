import 'package:bestpay/model/customer.dart';
import 'package:bestpay/model/payment.dart';

import '../../../../locator.dart';
import '../../../vgts_base_view_model.dart';

class PaymentViewModel extends VGTSBaseViewModel{
  int _tabCurrentIndex = 0;
  bool _mainPageLoading = true;
  bool get mainPageLoading => _mainPageLoading;
  List<CustomerCollection> customerList = [];
  List<PaymentCollection> paymentList = [];
  set mainPageLoading(bool value){
    _mainPageLoading = value;

    notifyListeners();
  }

  int get tabCurrentIndex => _tabCurrentIndex;
  set tabCurrentIndex(int value) {
    _tabCurrentIndex = value;
    notifyListeners();
  }

  onInIt(){
    tabChange(tabCurrentIndex);
    notifyListeners();
  }

  tabChange(int index) async{
    if (index != 1) {
      customerList = await dataBaseService.getCustomerList();
    }
    else if (index == 1) {
      paymentList = await dataBaseService.getPaymentList();
    }
    _mainPageLoading= false;
    notifyListeners();
  }
}