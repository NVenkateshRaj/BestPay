import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/model/kyclist.dart';
import 'package:bestpay/model/user.dart';
import 'package:bestpay/router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import '../../../locator.dart';
import '../../vgts_base_view_model.dart';

class UserProfileViewModel extends VGTSBaseViewModel{
  NameFormFieldController userNameController = NameFormFieldController(ValueKey("txtCompanyname"),required: true,requiredText: "Enter your Name");
  PhoneFormFieldController phoneNumberController = PhoneFormFieldController(ValueKey("txtPhone"), requiredText: "Please Enter Mobile Number",);
  ImageFieldController itemImageController = ImageFieldController(ValueKey("txtProductDesc"),required: false,);
  UserDetails? userDetails;
  KYCDetails? kycDetails;
  bool _mailPageLoading = false;

  bool get mainPageLoading => _mailPageLoading;

  set mainPageLoading(bool value){
    _mailPageLoading = value;
    notifyListeners();
  }

  inIt(){
    mainPageLoading = true;
    getKYcDetails();
    getUserDetails();
    notifyListeners();
  }

  getUserDetails()async{
    userDetails = await dataBaseService.getUserData(preferenceService.getUserPhone());
    userNameController.text = userDetails!.name;
    phoneNumberController.text = userDetails!.phoneNumber;
    notifyListeners();
  }

  getKYcDetails()async{
    kycDetails = await dataBaseService.getKYCList();
    mainPageLoading = false;
    notifyListeners();
  }

  updateUserDetails()async{
    setState(ViewState.Busy);
    try{
      userDetails =UserDetails(
        name: userNameController.text,
        phoneNumber: phoneNumberController.text,
        userId: userDetails!.userId,
        password: userDetails!.password
      );
      print(userDetails!.toJson());
      await dataBaseService.updateUserList(userDetails!);
      navigationService.popAllAndPushNamed(Routes.dashboard);
    }catch(e){
      Fluttertoast.showToast(msg: "Profile Not Update Please check your connectivity");
    }
    setState(ViewState.Idle);
    notifyListeners();
  }

}