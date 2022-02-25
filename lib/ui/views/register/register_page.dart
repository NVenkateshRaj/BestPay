import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/views/register/register_viewmodel.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:bestpay/ui/widgets/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';
import '../../../router.dart';


class RegisterPage extends ViewModelBuilderWidget<RegisterViewModel>{
  var data;
  RegisterPage(this.data);

  @override
  void onViewModelReady(RegisterViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.onInIt(data: data);
  }
  @override
  Widget builder(BuildContext context, RegisterViewModel viewModel, Widget? child) {

    return  Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.background,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderWidget(),
                VerticalSpacing.custom(value: 22.0),
                _UserInfo()
              ],
            ),
          ),
        ),
        bottomNavigationBar:Wrap(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
                child:   _SubScribeButton(),
            ),
          ],
        )
    );
  }
  @override
  RegisterViewModel viewModelBuilder(BuildContext context) => RegisterViewModel();
}
class _HeaderWidget extends ViewModelWidget<RegisterViewModel>{
  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Create Account",style: AppTextStyle.headerExtraBold,),
            HorizontalSpacing.custom(value: 16.0),
          ],
        ),
        VerticalSpacing.custom(value: 8.0),
        Text("Open a Best Pay account with a few details..",style: AppTextStyle.bodyRegular.copyWith(height: 21.08/14),),
      ],
    );
  }
}
class _UserInfo extends ViewModelWidget<RegisterViewModel>{
  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    // TODO: implement build
    return Form(
      key: viewModel.userInfoFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditTextField(
            "User Name  ",
            viewModel.userNameController,
            placeholder: "Enter Your Name",
            onChanged: (value){},
            onSubmitted: (val){
              viewModel.phoneFormFieldController.focusNode.requestFocus();
            },
          ),
          VerticalSpacing.custom(value: 20.0),
          EditTextField(
            "Mobile Number ",
            viewModel.phoneFormFieldController,
            placeholder: "Enter Your Phone Number",
            onChanged: (value){},
            onSubmitted: (val){
              viewModel.passwordController.focusNode.requestFocus();
            },
          ),
          VerticalSpacing.custom(value: 20.0),

          EditTextField.password(
            "Password ",
            viewModel.passwordController,
            placeholder: "Enter Your password",
            onChanged: (value){},
            onSubmitted: (val){
              viewModel.conFirmPasswordController.focusNode.requestFocus();
            },
          ),
          VerticalSpacing.custom(value: 20.0),
          EditTextField.password(
            "Confirm Password ",
            viewModel.conFirmPasswordController,
            placeholder: "Enter Your password",
            onChanged: (value){},
            onSubmitted: (val){
              FocusNode().requestFocus();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: viewModel.isChecked,
                activeColor: AppColor.primary,
                focusColor:  AppColor.borderColor,
                onChanged: (value)async{
                  viewModel.selectTerms(viewModel.isChecked);
                },
              ),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'By Signing Up, You Agree To Our',style: AppTextStyle.captionRegular.copyWith(height: 21.08/14)),
                      TextSpan(
                        text: ' Terms & Conditions',
                        style: AppTextStyle.captionMedium.copyWith(fontWeight: FontWeight.w700).copyWith(height: 21.08/14),),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _SubScribeButton extends ViewModelWidget<RegisterViewModel>{
  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Button(
              "SUBSCRIBE NOW",
              key: Key("SubscribeBtn"),
              isLoading: viewModel.state == ViewState.Busy,
              onPressed:(){
                if(viewModel.state != ViewState.Busy){
                  if(viewModel.userInfoFormKey.currentState?.validate() == true){
                    viewModel.subscribeOnClick();
                  }
                }
              },
            ),
          ),
          VerticalSpacing.custom(value: 20.5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already Have an account ? ",style: AppTextStyle.bodyRegular.copyWith(color: AppColor.grey),),

              HorizontalSpacing.custom(value: 2.0),

              InkWell(
                onTap: (){
                  navigationService.pushReplacementNamed(Routes.logIn);
                },
                child: Text("Login",style: AppTextStyle.subtitleBold.copyWith(color: AppColor.primary),),
              ),
            ],
          ),
        ],
      ),
    );
  }

}



