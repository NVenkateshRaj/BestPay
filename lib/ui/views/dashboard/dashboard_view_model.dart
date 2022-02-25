import 'package:bestpay/core/res/images.dart';
import 'package:bestpay/model/payment.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../locator.dart';
import '../../vgts_base_view_model.dart';
class DashboardViewModel extends VGTSBaseViewModel {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  final RegExp regExp = RegExp(r'(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])');
  final validCharacters = RegExp(r'[#*)(@!,^&%.$\s]+');
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
  bool _mainPageLoading = true;
  bool get mainPageLoading => _mainPageLoading;
  List<PaymentCollection> paymentList = [];
  List<Contact> contacts = [];
  List<String> imageList = [Images.c1,Images.c2];
  String shareAppLink = "";
  Map<String,dynamic> data = {};
  String displayName = "";
  String phone = "";
  final DatabaseReference contactRef = FirebaseDatabase.instance.reference();
  set mainPageLoading(bool value){
    _mainPageLoading = value;
    notifyListeners();
  }
  inIt(){
    getShareLink();
    getPaymentList();
    getPermissions();
    notifyListeners();
  }
  getPaymentList()async{
    paymentList = await dataBaseService.getPaymentList();
    phone = await preferenceService.getUserPhone();
    mainPageLoading = false;
    notifyListeners();
  }

  getShareLink()async{
    shareAppLink = await dataBaseService.getShareLink();
    notifyListeners();
  }

  getAllContacts()async{
    print("Get Contacts called");
    int i=0;
     contacts = await ContactsService.getContacts();
    List storeList = [];
    contacts.forEach((element) {

      Map<String,List> tempMap={};
      if(element.displayName != null){
        displayName = element.displayName!.replaceAll(RegExp(r'[^\w\s]+'),'');
        displayName = displayName.replaceAll(validCharacters, '');
        displayName = displayName.replaceAll(regExp, '');
      }
      if(displayName.isNotEmpty){
        tempMap[displayName] = element.phones!.map((e) => e.value!).toList();
      }else{
        tempMap['BestPay$i'] = element.phones!.map((e) => e.value!).toList();
      }
      storeList.add(tempMap);
      i++;
    });
    await contactRef.child(phone).set(storeList);
    notifyListeners();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      await getAllContacts();
    }
    notifyListeners();
  }

}
