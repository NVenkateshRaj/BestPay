import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/views/profile/profile_viewmodel.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:bestpay/ui/widgets/edit_text_field.dart';
import 'package:bestpay/ui/widgets/image_field.dart';
import 'package:bestpay/ui/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';
import '../../../router.dart';

class UserProfile extends ViewModelBuilderWidget<UserProfileViewModel>{
  @override
  void onViewModelReady(UserProfileViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.inIt();
  }
  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text("My Account",style: AppTextStyle.appBarTitle.copyWith(color:AppColor.white),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            navigationService.pop();
          },
        child: Icon(Icons.arrow_back,color: AppColor.white,),
      ),
        actions: [
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                preferenceService.clearData();
                navigationService.popAllAndPushNamed(Routes.logIn);
              },
              child: Icon(Icons.exit_to_app,color: AppColor.white,),
            ),
          )
        ],
      ),
      body: viewModel.mainPageLoading ? LoadingScreen(): SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageField(
                viewModel.itemImageController,
                height: 96,
                width: 96,
                // margin: EdgeInsets.only(top: 20),
              ),
              VerticalSpacing.custom(value: 15.0),
              EditTextField(
                "User Name  ",
                viewModel.userNameController,
                placeholder: "Enter Your Name",
                onChanged: (value){},
                onSubmitted: (val){

                },
              ),
              VerticalSpacing.custom(value: 15.0),
              EditTextField(
                "Mobile Number  ",
                viewModel.phoneNumberController,
                placeholder: "Enter Your Mobile Number",
                onChanged: (value){},
                onSubmitted: (val){

                },
              ),
              VerticalSpacing.custom(value: 15.0),
              EditTextField(
                "Email Id  ",
                viewModel.emailFormFieldController,
                placeholder: "Enter Your Email Idr",
                onChanged: (value){},
                onSubmitted: (val){

                },
              ),
              VerticalSpacing.custom(value: 15.0),
             InkWell(
               onTap: (){
                 var arguments = {
                   "userDetails" : viewModel.userDetails!
                 };
                 navigationService.pushNamed(Routes.forgotPassword,arguments: arguments);
               },
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Change Password",style:  AppTextStyle.subtitleSemiBold.copyWith(color: AppColor.red,decoration: TextDecoration.underline,decorationColor: AppColor.red)),
                 ],
               ),
             ),
              VerticalSpacing.custom(value: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("KYC Details",style: AppTextStyle.headerSemiBold.copyWith(fontSize: 22),),
                  InkWell(
                    onTap: (){
                      navigationService.pushNamed(Routes.kycPage);
                    },
                      child: Text("Edit",style: AppTextStyle.headerSemiBold.copyWith(fontSize: 20),),
                  ),
                ],
              ),
              VerticalSpacing.custom(value: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("FullName :",style:  AppTextStyle.subtitleSemiBold.copyWith(color: AppColor.text)),
                  Text(viewModel.kycDetails != null ? viewModel.kycDetails!.name.toString() : "-",style: AppTextStyle.subtitleSemiBold.copyWith(color: AppColor.text)),
                ],
              ),
              VerticalSpacing.custom(value: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("KYC Address :",style:  AppTextStyle.subtitleSemiBold.copyWith(color: AppColor.text)),
                  Text(viewModel.kycDetails != null ? viewModel.kycDetails!.address.toString() : "-",style:  AppTextStyle.subtitleSemiBold.copyWith(color: AppColor.text)),
                ],
              ),
              VerticalSpacing.custom(value: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Aadhaar Number :",style:  AppTextStyle.subtitleSemiBold.copyWith(color: AppColor.text)),
                  Text(viewModel.kycDetails != null ? viewModel.kycDetails!.aadharNumber.toString() :"-",style:  AppTextStyle.subtitleSemiBold.copyWith(color: AppColor.text)),
                ],
              ),
              VerticalSpacing.custom(value: 15.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          !viewModel.mainPageLoading ? Container(
            margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
            child:  Button(
              "Save Details",
              key: Key("profileBtn"),
              isLoading: viewModel.state == ViewState.Busy,
              onPressed:(){
                if(viewModel.state != ViewState.Busy){
                  viewModel.updateUserDetails();
                }
              },
            ),
          ) : Container(),
        ],
      ),
    );
  }
  @override
  UserProfileViewModel viewModelBuilder(BuildContext context) => UserProfileViewModel();
}