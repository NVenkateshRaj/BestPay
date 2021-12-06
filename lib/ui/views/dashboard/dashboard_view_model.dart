import 'package:bestpay/model/payment.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../locator.dart';
import '../../vgts_base_view_model.dart';
class DashboardViewModel extends VGTSBaseViewModel {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
  bool _mainPageLoading = true;
  bool get mainPageLoading => _mainPageLoading;
  List<PaymentCollection> paymentList = [];
  List<Contact> contacts = [];
  Map<String,dynamic> data = {};
  final DatabaseReference contactRef = FirebaseDatabase.instance.reference();
  set mainPageLoading(bool value){
    _mainPageLoading = value;
    notifyListeners();
  }
  inIt(){
    getPaymentList();
    getPermissions();
    notifyListeners();
  }
  getPaymentList()async{
    paymentList = await dataBaseService.getPaymentList();
    mainPageLoading = false;
    notifyListeners();
  }

  getAllContacts()async{
     contacts = await ContactsService.getContacts();
    List storeList = [];
    contacts.forEach((element) {
      Map<String,List> tempMap={};
      tempMap[element.displayName!.replaceAll(RegExp(r'[^\w\s]+'),'')]= element.phones!.map((e) => e.value!).toList();
      storeList.add(tempMap);
    });
    print(storeList.length);
    await contactRef.child(preferenceService.getUserPhone()).set(storeList);
    notifyListeners();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
    }
    notifyListeners();
  }

}
