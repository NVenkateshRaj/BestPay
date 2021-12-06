import 'dart:io';
import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/images.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:bestpay/ui/widgets/edit_text_field.dart';
import 'package:bestpay/ui/widgets/image_field.dart';
import 'package:bestpay/ui/widgets/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import '../../../locator.dart';
import 'kyc_viewmodel.dart';

class KYCPage extends ViewModelBuilderWidget<KYCViewModel>{

  @override
  void onViewModelReady(KYCViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.inIt();
  }
  @override
  Widget builder(BuildContext context, KYCViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0.0,
        centerTitle: true,
        title: Text("KYC",style: AppTextStyle.appBarTitle.copyWith(color: AppColor.white),),
        leading:InkWell(
          onTap: (){
            navigationService.pop();
          },
          child: Icon(Icons.arrow_back,color: AppColor.white,),
        ),
    ),
      body: viewModel.mainPageLoading? LoadingScreen() :SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.userInfoFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditTextField(
                  "Name  ",
                  viewModel.userNameController,
                  placeholder: "Enter Your Name",
                  onChanged: (value){},
                  onSubmitted: (val){
                    viewModel.aadharController.focusNode.requestFocus();
                  },
                ),
                VerticalSpacing.custom(value: 15.0),
                EditTextField(
                  "Aadhar Number  ",
                  viewModel.aadharController,
                  placeholder: "Enter Your AadharCard Number",
                  onChanged: (value){},
                  onSubmitted: (val){
                    viewModel.addressController.focusNode.requestFocus();
                  },
                ),
                VerticalSpacing.custom(value: 15.0),
                EditTextField(
                  "Address  ",
                  viewModel.addressController,
                  placeholder: "Enter Address",
                  onChanged: (value){},
                  onSubmitted: (val){
                    FocusNode().requestFocus();
                  },
                ),
                VerticalSpacing.custom(value: 15.0),

                Text("Aadhar Card Image",style: AppTextStyle.subheading.copyWith(color: Color(0xff001533),)),
                VerticalSpacing.custom(value: 15.0),
                InkWell(
                  onTap: ()async{
                    viewModel.aadharImage = await viewModel.picker.pickImage(source: ImageSource.camera);
                    viewModel.notifyListeners();
                  },
                  child: viewModel.aadharImage !=null ? Container(
                  height: 100,
                  width: 100,
                  child:Stack(
                    children: [
                      Image.file(File(viewModel.aadharImage!.path)),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(Icons.edit),
                      )
                    ],
                  ),
                ) : viewModel.aImage.isNotEmpty ?  Container(
                    height: 100,
                    width: 100,
                    child:Stack(
                      children: [
                        // CachedNetworkImage(
                        //   imageUrl: viewModel.aImage,
                        //   placeholder: (context, url) => CircularProgressIndicator(),
                        //   errorWidget: (context, url, error) => Icon(Icons.error),
                        // ),
                       Image.network(viewModel.aImage),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.edit),
                        )
                      ],
                    )
                    ,
                  ) :  Container(
                    padding: EdgeInsets.all(8.0),
                    color: AppColor.primary,
                    child: Text("Aadhar",style: TextStyle(fontSize: 15, fontFamily: AppStyle.fontFamily, fontWeight: FontWeight.w500, color: AppColor.white, letterSpacing: 1.5),),
                  ),
                ),

                VerticalSpacing.custom(value: 15.0),

                Text("Pick a Selfie",style: AppTextStyle.subheading.copyWith(color: Color(0xff001533),)),
                VerticalSpacing.custom(value: 20.0),
                InkWell(
                  onTap: ()async{
                    viewModel.userSelfie = await viewModel.picker.pickImage(source: ImageSource.camera);
                    viewModel.notifyListeners();
                  },
                  child: viewModel.userSelfie !=null ? Container(
                    height: 100,
                    width: 100,
                    child:Stack(
                      children: [
                        Image.file(File(viewModel.userSelfie!.path)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.edit),
                        )
                      ],
                    ),
                  ) : viewModel.imageUrl.isNotEmpty  ? Container(
                    height: 100,
                    width: 100,
                    child:  Stack(
                      children: [
                        // CachedNetworkImage(
                        //   imageUrl: viewModel.imageUrl,
                        //   placeholder: (context, url) => CircularProgressIndicator(),
                        //   errorWidget: (context, url, error) => Icon(Icons.error),
                        // ),
                        Image.network(viewModel.imageUrl),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.edit),
                        )
                      ],
                    )
                  ):  Container(
                    padding: EdgeInsets.all(8.0),
                    color: AppColor.primary,
                    child: Text("Selfie",style: TextStyle(fontSize: 15, fontFamily: AppStyle.fontFamily, fontWeight: FontWeight.w500, color: AppColor.white, letterSpacing: 1.5),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        bottomNavigationBar:Wrap(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
              child:   viewModel.mainPageLoading?  Container():_SaveButton(),
            ),
          ],
        )
    );
  }

  @override
  KYCViewModel viewModelBuilder(BuildContext context) => KYCViewModel();

}

class _SaveButton extends ViewModelWidget<KYCViewModel>{
  @override
  Widget build(BuildContext context, KYCViewModel viewModel) {
    return Button(
      "Save",
      key: Key("SaveBtn"),
      width: double.infinity,
      isLoading: viewModel.state == ViewState.Busy,
      onPressed:(){
        if(viewModel.state != ViewState.Busy){
          if(viewModel.userInfoFormKey.currentState?.validate() == true){
            viewModel.saveBtnClicked();
          }
        }
      },
    );
  }

}