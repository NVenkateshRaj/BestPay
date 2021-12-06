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
import 'customer_viewmodel.dart';
class CreateCustomer extends ViewModelBuilderWidget<CustomerViewModel> {

  var data;

  CreateCustomer({this.data});

  @override
  void onViewModelReady(CustomerViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.inIt(data: data);
  }
  @override
  Widget builder(BuildContext context, CustomerViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text("Create Customer",style: AppTextStyle.appBarTitle.copyWith(color:AppColor.white),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            navigationService.pop();
          },
          child: Icon(Icons.arrow_back,color: AppColor.white,),
        ),
        actions: [
          viewModel.isEdit ? InkWell(
            onTap: (){
              viewModel.deleteCustomer();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.delete_sharp,color: AppColor.background,),
            ),
          ): Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: [
              _UserInfo()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
            child:   _SaveButton(),
          ),
        ],
      ),

    );
  }
  @override
  CustomerViewModel viewModelBuilder(BuildContext context) => CustomerViewModel();
}
class _UserInfo extends ViewModelWidget<CustomerViewModel>{
  @override
  Widget build(BuildContext context, CustomerViewModel viewModel) {
    // TODO: implement build
    return Form(
      key: viewModel.userInfoFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditTextField(
            "Account Holder Name",
            viewModel.userNameController,
            placeholder: "Enter Your Name",
            onChanged: (value){},
            onSubmitted: (val){
              viewModel.nickNameController.focusNode.requestFocus();
            },
          ),
          VerticalSpacing.custom(value: 20.0),
          EditTextField(
            "Nick Name",
            viewModel.nickNameController,
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

            },
          ),
          VerticalSpacing.custom(value: 20.0),
          EditTextField(
            "Account Number",
            viewModel.accountNumberFieldController,
            placeholder: "Enter Your Account Number",
            onChanged: (value){},
            onSubmitted: (val){

            },
          ),
          VerticalSpacing.custom(value: 20.0),
          EditTextField(
            "IFSC Code ",
            viewModel.ifscCodeController,
            placeholder: "Enter Your IFSC Code",
            onChanged: (value){},
            onSubmitted: (val){
              FocusNode().requestFocus();
            },
          ),
          VerticalSpacing.custom(value: 20.0),
        ],
      ),
    );
  }

}

class _SaveButton extends ViewModelWidget<CustomerViewModel>{
  @override
  Widget build(BuildContext context, CustomerViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Button(
              "Save",
              key: Key("SaveBtn"),
              isLoading: viewModel.state == ViewState.Busy,
              onPressed:(){
                if(viewModel.state != ViewState.Busy){
                  if(viewModel.userInfoFormKey.currentState?.validate() == true){
                    viewModel.saveBtnClick();
                  }
                }

              },
            ),
          ),
          VerticalSpacing.custom(value: 20.5),
        ],
      ),
    );
  }

}