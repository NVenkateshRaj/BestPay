import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:bestpay/ui/widgets/dropdown.dart';
import 'package:bestpay/ui/widgets/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import '../../../locator.dart';
import 'cardpage_viewmodel.dart';
class AddCard extends ViewModelBuilderWidget<CardPageViewModel>{
  @override
  void onViewModelReady(CardPageViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.inIt();
  }
  @override
  Widget builder(BuildContext context, CardPageViewModel viewModel, Widget? child) {

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text("Add Credit Card",style: AppTextStyle.appBarTitle.copyWith(color:AppColor.white),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            navigationService.pop();
          },
          child: Icon(Icons.arrow_back,color: AppColor.white,),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.userInfoFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditTextField(
                  "Credit Card Holder Name ",
                  viewModel.userNameController,
                  placeholder: "Enter Your Name",
                  onChanged: (value){},
                  onSubmitted: (val){
                    viewModel.cardController.focusNode.requestFocus();
                  },
                ),

                VerticalSpacing.custom(value: 20.0),
                EditTextField(
                  "Credit Card Number ",
                  viewModel.cardController,
                  placeholder: "Enter Credit Card Number",
                  onChanged: (value){},
                  onSubmitted: (val){
                    //  viewModel.emailFormFieldController.focusNode.requestFocus();
                  },
                ),
                VerticalSpacing.custom(value: 20.0),
                DropdownField(
                  "Select Bank",
                  viewModel.bankController,
                  placeholder: "Select Bank",
                  onChange: (value){},
                ),
              ],
            ),
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
  CardPageViewModel viewModelBuilder(BuildContext context) => CardPageViewModel();
}

class _SaveButton extends ViewModelWidget<CardPageViewModel>{
  @override
  Widget build(BuildContext context, CardPageViewModel viewModel) {

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
              onPressed:()async{
                if(viewModel.state != ViewState.Busy){
                  if(viewModel.userInfoFormKey.currentState?.validate() == true){
                    await viewModel.saveCard();
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