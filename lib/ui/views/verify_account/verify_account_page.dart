import 'dart:io';
import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/views/verify_account/verifyaccount_viewModel.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';

class VerifyAccountPage extends ViewModelBuilderWidget<VerifyAccountViewModel>{
  var data;
  VerifyAccountPage(this.data);
  @override
  void onViewModelReady(VerifyAccountViewModel viewModel) {
    viewModel.init(data: data);
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }
  @override
  Widget builder(BuildContext context, VerifyAccountViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar:  AppBar(
        backgroundColor: AppColor.background,
        elevation: 0.0,
        leading: InkWell(
          onTap: (){
            navigationService.pop();
          },
          child: Icon(Icons.close,color:AppColor.black),
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.verifyAccountFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderWidget(),
                  VerticalSpacing.custom(value: 50.0),
                  _OTPField(),
                  VerticalSpacing.custom(value: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      viewModel.counter == 0 ? InkWell(
                        onTap: (){
                          viewModel.resendOtp();
                        },
                        child: Text("Resend",style: AppTextStyle.subtitleSemiBold.copyWith(color: AppColor.red),),
                      ) : Container(),

                    ],
                  ),
                ],
              ),
            ),
          )
      ),
      bottomNavigationBar: Wrap(
        children: [
          SafeArea(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Center(
                child: Button(
                  "VERIFY PHONE NUMBER",
                  isLoading: viewModel.state == ViewState.Busy,
                  key: Key("VerifyPhoneBtn"),
                  onPressed:(){
                    if(viewModel.state != ViewState.Busy){
                      viewModel.verifyBtnClick();
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  VerifyAccountViewModel viewModelBuilder(BuildContext context) => VerifyAccountViewModel();
}
class _HeaderWidget extends ViewModelWidget<VerifyAccountViewModel>{
  @override
  Widget build(BuildContext context, VerifyAccountViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Verify Account",style: AppTextStyle.headerExtraBold,),
        VerticalSpacing.custom(value: 8.0),
        Text("Please enter the CODE sent to your phone number in the boxes below.",style: AppTextStyle.bodyRegular.copyWith(height: 21.08/14),),
      ],
    );
  }
}

class _OTPField extends ViewModelWidget<VerifyAccountViewModel>{
  @override
  Widget build(BuildContext context, VerifyAccountViewModel viewModel) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        pastedTextStyle: AppTextStyle.subheading,
        length: 6,
        autoFocus: true,
        obscureText: false,
        enablePinAutofill: true,
        blinkDuration: Duration(seconds: 50),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(6.0),
          fieldHeight: 50,
          fieldWidth: 54,
          borderWidth:2.0,
          disabledColor:AppColor.borderColor,
          inactiveColor:AppColor.borderColor ,
          inactiveFillColor:AppColor.white ,
          activeColor:AppColor.white,
          selectedColor: AppColor.borderColor,
          selectedFillColor: AppColor.white,
         activeFillColor: AppColor.white ,
        ),
        cursorColor: AppColor.primaryBlue,
        textStyle: AppTextStyle.appBarTitle.copyWith(fontWeight: FontWeight.w700),
        controller: viewModel.otpController.textEditingController,
        animationType: AnimationType.none,
        animationDuration: Duration(seconds: 0),
        animationCurve:Curves.decelerate,
        keyboardType: TextInputType.number,
        enableActiveFill: true,
        onCompleted: (v) {},
        onChanged: (value) {
          viewModel.notifyListeners();
        },
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.digitsOnly,
        ],
        beforeTextPaste: (text) {
          return false;
        },
      ),
    );
  }
}
