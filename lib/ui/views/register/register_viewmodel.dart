import 'package:bestpay/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import '../../../locator.dart';
import '../../../router.dart';
import '../../vgts_base_view_model.dart';
class RegisterViewModel extends VGTSBaseViewModel{
  TextFormFieldController passwordController = TextFormFieldController(ValueKey("txtRegisterPassword"), requiredText: "Enter Password",required: true,);
  TextFormFieldController conFirmPasswordController = TextFormFieldController(ValueKey("txtConfirmPassword"), requiredText: "Enter Confirm Password",required: true,);
  NameFormFieldController userNameController = NameFormFieldController(ValueKey("txtCompanyname"),required: true,requiredText: "Enter your Name");
  PhoneFormFieldController phoneFormFieldController = PhoneFormFieldController(ValueKey("txtPhone"),required: true,requiredText: "Enter your Phone Number");
  EmailFormFieldController emailFormFieldController = EmailFormFieldController(ValueKey("txtEmail"),required: true,requiredText: "Enter your Email Id");
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
      emailFormFieldController.text = data['email'];
    }
    notifyListeners();
    print(userNameController.text);
  }
  subscribeOnClick()async{
   if(passwordController.text == conFirmPasswordController.text){
     if(isChecked){
       UserDetails userDetails = UserDetails(
           name: userNameController.text,
           phoneNumber: phoneFormFieldController.text,
           email: emailFormFieldController.text,
           password: passwordController.text
       );
       var arguments = {
         'screenFrom': Routes.register,
         'phoneNumber':phoneFormFieldController.text,
         'userDetails':userDetails,
       };
       navigationService.pushNamed(Routes.otpScreen,arguments: arguments);
     }
     else{
       Fluttertoast.showToast(msg: "Please Select Terms and Condition");
     }
    }
    else{
      Fluttertoast.showToast(msg: "New Password and Confirm Password Must Be Same");
    }
    notifyListeners();
  }
  selectTerms(bool value){
    _isChecked = !value;
    notifyListeners();
  }
}