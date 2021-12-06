import 'package:bestpay/model/kyclist.dart';
import 'package:bestpay/model/user.dart';
import 'package:flutter/material.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import '../../../locator.dart';
import '../../vgts_base_view_model.dart';

class UserProfileViewModel extends VGTSBaseViewModel{
  NameFormFieldController userNameController = NameFormFieldController(ValueKey("txtCompanyname"),required: true,requiredText: "Enter your Name");
  PhoneFormFieldController phoneNumberController = PhoneFormFieldController(ValueKey("txtPhone"), requiredText: "Please Enter Mobile Number",);
  EmailFormFieldController emailFormFieldController = EmailFormFieldController(ValueKey("txtEmail"),required: true,requiredText: "Enter your Email Id");
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
    emailFormFieldController.text = userDetails!.email;
  }

  getKYcDetails()async{
    kycDetails = await dataBaseService.getKYCList();
    mainPageLoading = false;
    notifyListeners();
  }

  updateUserDetails()async{
  await dataBaseService.updateUserList(userDetails!);
  }

}