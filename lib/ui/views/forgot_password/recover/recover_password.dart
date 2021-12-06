import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:bestpay/ui/widgets/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import '../../../../locator.dart';
import '../forgotpassword_viewmodel.dart';

class RecoverPassword extends ViewModelBuilderWidget<ForgotPasswordViewModel>{
  var data;
  RecoverPassword(this.data);
  @override
  void onViewModelReady(ForgotPasswordViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.onInIt(data: data);
  }
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

      body:  Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.recoverPasswordFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderWidget(),
                  VerticalSpacing.custom(value: 50.0),
                  _PasswordFields(),
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
                  "RESET PASSWORD",
                  key: Key("ResetPasswordBtn"),
                  isLoading: viewModel.state == ViewState.Busy,
                  onPressed:(){
                    if(viewModel.state != ViewState.Busy){
                      if(viewModel.recoverPasswordFormKey.currentState?.validate() == true){
                        viewModel.resetPasswordBtnClick();
                      }
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
  ForgotPasswordViewModel viewModelBuilder(BuildContext context) => ForgotPasswordViewModel();

}

class _HeaderWidget extends ViewModelWidget<ForgotPasswordViewModel>{
  @override
  Widget build(BuildContext context, ForgotPasswordViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recover Password", style: AppTextStyle.headerExtraBold,),
        VerticalSpacing.custom(value: 8.0),
        Text("Please enter your new password to continue",
          style: AppTextStyle.bodyRegular.copyWith(height: 21.08 / 14),),
      ],
    );
  }
}
class _PasswordFields extends ViewModelWidget<ForgotPasswordViewModel>{
  @override
  Widget build(BuildContext context, ForgotPasswordViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditTextField.password(
          "Password ",
          viewModel.newPasswordController,
          placeholder: "Enter New Password",
          onChanged: (value){},
          onSubmitted: (val){
            viewModel.confirmPasswordController.focusNode.requestFocus();
          },
        ),
        VerticalSpacing.custom(value: 24.0),
        EditTextField.password(
          "Confirm Password ",
          viewModel.confirmPasswordController,
          placeholder: "Retype Password",
          onChanged: (value){},
          onSubmitted: (val){
            FocusNode().requestFocus();
          },
        ),
      ],
    );
  }
}

