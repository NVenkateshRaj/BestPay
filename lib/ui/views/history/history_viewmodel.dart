import 'package:bestpay/model/payment.dart';
import '../../../locator.dart';
import '../../vgts_base_view_model.dart';
class HistoryViewModel extends VGTSBaseViewModel{
  bool _mainPageLoading = true;
  bool get mainPageLoading => _mainPageLoading;
  List<PaymentCollection> paymentList = [];
  set mainPageLoading(bool value){
    _mainPageLoading = value;
    notifyListeners();
  }
  inIt(){
    getPaymentList();
  }
  getPaymentList()async{
    paymentList = await dataBaseService.getPaymentList();
    mainPageLoading = false;
    notifyListeners();
  }
}