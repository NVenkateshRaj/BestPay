import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import '../../../locator.dart';
import '../../../router.dart';
import '../../vgts_base_view_model.dart';
class RegisterViewModel extends VGTSBaseViewModel{
  var uuid = Uuid();
  TextFormFieldController passwordController = TextFormFieldController(ValueKey("txtRegisterPassword"), requiredText: "Enter Password",required: true,);
  TextFormFieldController conFirmPasswordController = TextFormFieldController(ValueKey("txtConfirmPassword"), requiredText: "Enter Confirm Password",required: true,);
  NameFormFieldController userNameController = NameFormFieldController(ValueKey("txtCompanyname"),required: true,requiredText: "Enter your Name");
  PhoneFormFieldController phoneFormFieldController = PhoneFormFieldController(ValueKey("txtPhone"),required: true,requiredText: "Enter your Phone Number");
  int get initialPage => _initialPage;
  int _initialPage = 1;
  set initialPage(int value){
    _initialPage = value;
    notifyListeners();
  }
  bool get isChecked => _isChecked;
  bool _isChecked = false;
  final GlobalKey<FormState> userInfoFormKey = GlobalKey<FormState>();
  onInIt({data})async{
    if(data!=null){
      userNameController.text = data['name'];
    }
    notifyListeners();
  }
  subscribeOnClick()async{
    setState(ViewState.Busy);
   if(passwordController.text == conFirmPasswordController.text){
     if(isChecked){
       UserDetails userDetails = UserDetails(
           name: userNameController.text,
           phoneNumber: phoneFormFieldController.text,
           password: passwordController.text
       );
         String userId = uuid.v4();
       var data = await dataBaseService.getUserList(phoneFormFieldController.text);
         if(data==null){
           try{
             userDetails.userId = userId;
             await dataBaseService.createUserData(userDetails);
             preferenceService.setBearerToken(userId);
             preferenceService.setUserPhone(userDetails.phoneNumber!);
             navigationService.popAllAndPushNamed(Routes.dashboard);
           }catch(e){
             print(e);
           }
         }
         else{
           Fluttertoast.showToast(msg: "Phone Number Already Exist");
         }
     }
     else{
       Fluttertoast.showToast(msg: "Please Select Terms and Condition");
     }
    }
    else{
      Fluttertoast.showToast(msg: "New Password and Confirm Password Must Be Same");
    }
    setState(ViewState.Idle);
    notifyListeners();
  }
  selectTerms(bool value){
    _isChecked = !value;
    notifyListeners();
  }
}