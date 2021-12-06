import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:bestpay/ui/widgets/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import '../../../locator.dart';
import 'forgotpassword_viewmodel.dart';

class ForgotPasswordPage extends ViewModelBuilderWidget<ForgotPasswordViewModel>{
  @override
  Widget builder(BuildContext context, ForgotPasswordViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColor.background,
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
          key: viewModel.forgotPasswordFormKey,
          child: SingleChildScrollView(
            controller: viewModel.scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderWidget(),
                VerticalSpacing.custom(value: 50.0),
                EditTextField(
                  "Mobile Number ",
                  viewModel.phoneNumberController,
                  placeholder: "Enter Your Mobile Number",
                  onChanged: (value){},
                  onSubmitted: (val){
                    FocusNode().requestFocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          SafeArea(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Center(
                child: Button(
                    "RECOVER PASSWORD",
                    key: Key("PasswordBtn"),
                    isLoading: viewModel.state == ViewState.Busy,
                    onPressed:(){
                      if(viewModel.state != ViewState.Busy){
                        if(viewModel.forgotPasswordFormKey.currentState?.validate() == true){
                          viewModel.recoverBtnClick();
                        }
                      }
                    }
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  @override
  ForgotPasswordViewModel viewModelBuilder(BuildContext context) => ForgotPasswordViewModel();

}

class _HeaderWidget extends ViewModelWidget<ForgotPasswordViewModel>{
  @override
  Widget build(BuildContext context, ForgotPasswordViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Forgot Password",style: AppTextStyle.headerExtraBold,),
        VerticalSpacing.custom(value: 8.0),
        Text("Please enter your phone number to recover your password.",style: AppTextStyle.bodyRegular.copyWith(height: 21.08/14),),
      ],
    );
  }

}

