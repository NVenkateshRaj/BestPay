import 'dart:io';
import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/model/kyclist.dart';
import 'package:bestpay/router.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';

import '../../../locator.dart';
import '../../vgts_base_view_model.dart';

class KYCViewModel extends VGTSBaseViewModel{
  var uuid = Uuid();
  NameFormFieldController userNameController = NameFormFieldController(ValueKey("txtCompanyname"),required: true,requiredText: "Enter your Name");
  FormFieldController aadharController = FormFieldController(ValueKey("txtgst"),required: true,textCapitalization: TextCapitalization.characters,maxLength: 12,inputFormatter: [ FilteringTextInputFormatter.allow(RegExp("[0-9]")),],validator: (value) => gstNumberValidator(value,maxLength: 12),textInputType: TextInputType.number );
  TextFormFieldController addressController= TextFormFieldController(ValueKey("txtAddress1"),required: true,);
  final GlobalKey<FormState> userInfoFormKey = GlobalKey<FormState>();
  ImageFieldController itemImageController = ImageFieldController(ValueKey("txtProductDesc"),required: false,);
  KYCDetails? kycDetails;
  String imageUrl = "";
  String aImage = "";
  Directory? tempDir;
  bool isEdit =false;
  final ImagePicker picker = ImagePicker();
  XFile? userSelfie,aadharImage;
  static String? gstNumberValidator(String? value, { String? requiredText,int? maxLength }) {
    if (value?.isEmpty != false)
      return requiredText ?? "Enter Gst Number !";
    if (value?.length != maxLength) {
      return requiredText ?? "Invalid GST Number !";
    }
    return null;
  }

  bool _mailPageLoading = false;

  bool get mainPageLoading => _mailPageLoading;

  set mainPageLoading(bool value){
    _mailPageLoading = value;
    notifyListeners();
  }

  inIt(){
    mainPageLoading = true;
    getKycDetails();
    mainPageLoading = false;
  }

  getKycDetails()async{
    kycDetails = await dataBaseService.getKYCList();
    kycDetails !=null?  setData() : null;
    notifyListeners();
  }

  setData(){
    isEdit =true;
    userNameController.text = kycDetails!.name;
    addressController.text = kycDetails!.address;
    aadharController.text = kycDetails!.aadharNumber;
    imageUrl = kycDetails!.imageUrl!;
    aImage = kycDetails!.aadharImage!;

    notifyListeners();
  }

  Future<String> compressImageFile(File file) async {
    tempDir =await  getTemporaryDirectory();
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,"${tempDir!.absolute.path + "/temp.jpg"}",
      quality: 88,
    );
    return await postFile(File(result!.path));
  }

  saveBtnClicked()async{
    setState(ViewState.Busy);
    imageUrl = userSelfie !=null ? await compressImageFile(File(userSelfie!.path)): kycDetails != null && kycDetails!.imageUrl!.isNotEmpty ? kycDetails!.imageUrl! : "";
    aImage = aadharImage !=null ? await compressImageFile(File(aadharImage!.path)): kycDetails != null && kycDetails!.aadharImage!.isNotEmpty ? kycDetails!.aadharImage! : "";

    try{
      kycDetails = KYCDetails(
        name: userNameController.text,
        aadharNumber: aadharController.text,
        address: addressController.text,
        imageUrl: imageUrl,
        aadharImage:aImage,
        aadharId:isEdit? kycDetails!.aadharId : uuid.v4().toString(),
      );
      isEdit?  await dataBaseService.updateKYC(kycDetails!) :  await dataBaseService.createKYC(kycDetails!);
      navigationService.pop();
    }catch(e){

    }
    setState(ViewState.Idle);
    notifyListeners();
  }

   Future<String> postFile(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(preferenceService.getUserPhone()).child(fileName);
    TaskSnapshot storageTaskSnapshot  =await reference.putFile(imageFile);
    String dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return dowUrl;
  }

  deleteKyc()async{
    try {
      await dataBaseService.deleteKyc(kycDetails!.aadharId!);
      navigationService.pop();
      navigationService.popAllAndPushNamed(Routes.dashboard);
    }catch(e){}
  }


}