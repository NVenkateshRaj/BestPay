import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/model/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import '../../../locator.dart';
import '../../../router.dart';
import '../../vgts_base_view_model.dart';

class CustomerViewModel extends VGTSBaseViewModel{
  var uuid = Uuid();
  CustomerCollection customer =  CustomerCollection ();
  bool isEdit = false;
  final GlobalKey<FormState> userInfoFormKey = GlobalKey<FormState>();
  NameFormFieldController userNameController = NameFormFieldController(ValueKey("txtCompanyname"),required: true,requiredText: "Enter Account Holder Name");
  NameFormFieldController nickNameController = NameFormFieldController(ValueKey("txtCompanyname"),required: true,requiredText: "Enter Nick Name");
  PhoneFormFieldController phoneFormFieldController = PhoneFormFieldController(ValueKey("txtPhone"),required: true,requiredText: "Enter  Phone Number");
  PhoneFormFieldController accountNumberFieldController = PhoneFormFieldController(ValueKey("txtAccount"),required: true,requiredText: "Enter Account Number",maxLength: 16,);
  FormFieldController ifscCodeController= FormFieldController(ValueKey("txtIFSC"),required: true,maxLength: 11,validator: (value) => ifscCodeValidator(value,requiredText: "Invalid Ifsc Code",maxLength: 11));

  inIt({data}){
    if(data!=null){
      customer = data['customer'];
      isEdit = true;
      setData();
    }
    notifyListeners();
  }

  static String? ifscCodeValidator(String? value, { String? requiredText,int? maxLength }) {
    if (value?.isEmpty != false)
      return requiredText ?? "Enter Ifsc Code !";

    if (value?.length != maxLength) {
      return requiredText ?? "Invalid Ifsc Code !";
    }

    return null;
  }

  saveBtnClick()async{
    setState(ViewState.Busy);
    if(isEdit){
      customer = CustomerCollection(
          customerName: userNameController.text,
          nickName: nickNameController.text,
          phoneNumber: phoneFormFieldController.text,
          accountNumber: accountNumberFieldController.text,
          ifscCode: ifscCodeController.text,
          customerId: customer.customerId,
        createdAt: Timestamp.now(),
      );
    }
    else{
      customer = CustomerCollection(
          customerName: userNameController.text,
          nickName: nickNameController.text,
          phoneNumber: phoneFormFieldController.text,
          accountNumber: accountNumberFieldController.text,
          ifscCode: ifscCodeController.text,
          createdAt: Timestamp.now(),
          customerId: uuid.v4().toString()
      );
    }
   try{
     isEdit ? await  dataBaseService.updateCustomer(customer): await dataBaseService.createCustomer(customer);
     setState(ViewState.Idle);
     notifyListeners();
     navigationService.pop();
   }catch(e){
     print(e);
   }
  }


  setData(){
    userNameController.text = customer.customerName;
    nickNameController.text = customer.nickName;
    phoneFormFieldController.text = customer.phoneNumber;
    accountNumberFieldController.text = customer.accountNumber;
    ifscCodeController.text = customer.ifscCode;
  }

  deleteCustomer()async{
    try{
      await dataBaseService.deleteCustomer(customer.customerId!);
      navigationService.popAllAndPushNamed(Routes.dashboard);
    }catch(e){
      print(e);
    }
  }



}