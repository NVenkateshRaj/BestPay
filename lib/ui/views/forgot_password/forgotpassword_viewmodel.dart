import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import '../../../locator.dart';
import '../../../router.dart';
import '../../vgts_base_view_model.dart';

class ForgotPasswordViewModel extends VGTSBaseViewModel{
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> recoverPasswordFormKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  PhoneFormFieldController phoneNumberController = PhoneFormFieldController(ValueKey("txtPhone"),required: true);
  TextFormFieldController newPasswordController = TextFormFieldController(ValueKey("txtPassword"),required: true);
  TextFormFieldController confirmPasswordController = TextFormFieldController(ValueKey("txtPassword"),required: true);
  UserDetails? userDetails;
   onInIt({data}) {
     if(data!=null){
       userDetails = data['userDetails'];
     }
     notifyListeners();
  }
  recoverBtnClick()async{
     setState(ViewState.Busy);
     try{
       var data = await dataBaseService.getUserList(phoneNumberController.text);
       userDetails = UserDetails(
         name: data['name'],
         phoneNumber: data['phoneNumber'],
         userId: data['userId'],
         password: data['password']
       );
       var arguments = {
         'userDetails' : userDetails,
       };
       navigationService.pushNamed(Routes.recoverPassword,arguments: arguments);
     }catch(e){}
     setState(ViewState.Idle);
     notifyListeners();
  }

  resetPasswordBtnClick()async{
     setState(ViewState.Busy);
    try{
      if(newPasswordController.text == confirmPasswordController.text){
        userDetails!.password = confirmPasswordController.text;
        await dataBaseService.updateUserList(userDetails!);
        preferenceService.setUserPhone(userDetails!.phoneNumber!);
        preferenceService.setBearerToken(userDetails!.userId!);
        navigationService.popAllAndPushNamed(Routes.dashboard);
        setState(ViewState.Idle);
        notifyListeners();
      }
      else{
        Fluttertoast.showToast(msg: "New Password and Confirm Password Must Be Same");
      }
    }catch(e){}
    notifyListeners();
  }
}