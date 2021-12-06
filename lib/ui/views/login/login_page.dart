import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/images.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:bestpay/ui/widgets/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';
import '../../../router.dart';
import 'login_viewmodel.dart';

class LogInPage extends ViewModelBuilderWidget<LogInViewModel>{
  @override
  Widget builder(BuildContext context, LogInViewModel viewModel, Widget? child) {
    // TODO: implement builder
    return Scaffold(
        backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0.0,
      ),
      body:  Form(
        key: viewModel.logInFormKey,
        child:SingleChildScrollView(
          controller: viewModel.scrollController,
          child: Container(
            margin: EdgeInsets.only(left: 16.0,right: 16.0,bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(),
                VerticalSpacing.custom(value: 42.0),
                _LogInFields(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:Wrap(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
            child: _LogInButton(),
          ),
        ],
      )
    );
  }
  @override
  LogInViewModel viewModelBuilder(BuildContext context) => LogInViewModel();

}
class _Header extends ViewModelWidget<LogInViewModel>{
  @override
  Widget build(BuildContext context, LogInViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.appLogo,width: 100,height: 100,),
          VerticalSpacing.custom(value: 13.0),
          Text("Welcome Back",style: AppTextStyle.headerExtraBold,),
        ],
      ),
    );
  }
}

class _LogInFields extends ViewModelWidget<LogInViewModel>{
  @override
  Widget build(BuildContext context, LogInViewModel viewModel) {
    // TODO: implement build
   return Column(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       EditTextField(
         "Mobile Number ",
         viewModel.phoneNumberController,
         placeholder: "Enter Your Mobile Number",
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
           FocusNode().requestFocus();
         },
       ),
       VerticalSpacing.custom(value: 14.0),
       GestureDetector(
         onTap: (){
           viewModel.forgotPasswordOnClick();
         },
         child: Row(
           mainAxisAlignment: MainAxisAlignment.end,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Text("Forgot Password ?",style: AppTextStyle.subtitleSemiBold.copyWith(color: AppColor.red),),
             HorizontalSpacing.custom(value: 8.0),
             Image.asset(Images.forgotPasswordArrow,height: 12,width: 12.0,)
           ],
         ),
       ),
       VerticalSpacing.custom(value: 20.0),
       Center(child: Text("Other ways to sign in",style: AppTextStyle.bodyRegular.copyWith(color: AppColor.grey),)),
       VerticalSpacing.custom(value: 10.0),
       Center(
         child: InkWell(
           onTap: (){
             print("Google OnTap");
             viewModel.handleSignIn();
           },
           child: Image.asset(Images.googleLogo,height: 50,width: 50,),
         ),
       )
     ],
   );
  }
}

class _LogInButton extends ViewModelWidget<LogInViewModel>{
  @override
  Widget build(BuildContext context, LogInViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Button(
              "LOGIN",
              key: Key("logInBtn"),
              isLoading: viewModel.state == ViewState.Busy,
              onPressed:(){

                if(viewModel.state != ViewState.Busy){
                  if(viewModel.logInFormKey.currentState?.validate() == true){
                    viewModel.logInOnClick();
                  }
                }

              },
          ),
          VerticalSpacing.custom(value: 20.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't  Have an account ",style: AppTextStyle.bodyRegular.copyWith(color: AppColor.grey),),
              HorizontalSpacing.custom(value: 2.0),
              InkWell(
                onTap: (){
                  navigationService.pushReplacementNamed(Routes.register);
                },
                child: Text("Signup",style: AppTextStyle.subtitleBold.copyWith(color: AppColor.primary),),
              ),
            ],
          ),
          VerticalSpacing.custom(value: 10.5),
        ],
      ),
    );
  }
}