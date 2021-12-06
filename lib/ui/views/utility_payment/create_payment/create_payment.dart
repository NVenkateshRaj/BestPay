import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/fontsize.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/router.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:bestpay/ui/widgets/dropdown.dart';
import 'package:bestpay/ui/widgets/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../../../locator.dart';
import 'createpayment_viewmodel.dart';

class CreatePayment extends ViewModelBuilderWidget<CreatePaymentViewModel>{
  var data;

  CreatePayment(this.data);

  @override
  void onViewModelReady(CreatePaymentViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.inIt(data: data);
  }
  @override
  Widget builder(BuildContext context, CreatePaymentViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text("Create Payment",style: AppTextStyle.appBarTitle.copyWith(color:AppColor.white),),
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
                DetailsWidget(title: "Beneficiary Name",subTitle: viewModel.customer.customerName,),
                VerticalSpacing.custom(value: 15),
                DetailsWidget(title: "Beneficiary Nickname",subTitle: viewModel.customer.nickName,),
                VerticalSpacing.custom(value: 15),
                DetailsWidget(title: "Account Number",subTitle:viewModel.customer.accountNumber,),
                VerticalSpacing.custom(value: 15),
                DetailsWidget(title: "Beneficiary Mobile Number",subTitle: viewModel.customer.phoneNumber,),
                VerticalSpacing.custom(value: 15),
                DropdownField(
                  "PurPose *",
                  viewModel.purposeController,
                  placeholder: "Select Purpose",
                  onChange: (value){},
                ),
                VerticalSpacing.custom(value: 15),
                EditTextField(
                  "Amount",
                  viewModel.amountController,
                  placeholder: "",
                  onChanged: (value){},
                  onSubmitted: (val){
                    // viewModel.phoneFormFieldController.focusNode.requestFocus();
                  },
                ),
                VerticalSpacing.custom(value: 15),
                DropdownField(
                  "Transcation Priority",
                  viewModel.transcationController,
                  placeholder: "Select Bearer",
                  onChange: (value){
                    viewModel.notifyListeners();
                    viewModel.amountController.text.isNotEmpty ? viewModel.convertAmount(viewModel.amountController.text) : null;
                  },
                ),

                // VerticalSpacing.custom(value: 20),
                //
                // DropdownField(
                //   "Transcation Priority *",
                //   viewModel.transcationController,
                //   placeholder: "Select Priority",
                //   onChange: (value){
                //     viewModel.amountController.text.isNotEmpty ? viewModel.convertAmount(viewModel.amountController.text) : null;
                //   },
                // ),

                VerticalSpacing.custom(value: 20),
                viewModel.amountController.text.isNotEmpty ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Transcation Amount : ${viewModel.amountController.text}",style: AppTextStyle.subtitleBold1.copyWith(fontSize: AppFontSize.dp16,),),
                        VerticalSpacing.d2px(),
                        Text("Convenience Amount : ${viewModel.totalAmount!=null ||viewModel.totalAmount!=0? viewModel.totalAmount!.toStringAsFixed(2) : 0.0}",style: AppTextStyle.subtitleBold1.copyWith(fontSize: AppFontSize.dp16,),),
                        VerticalSpacing.d2px(),
                        Text("Gst Amount : ${viewModel.gstValue!=null ||viewModel.gstValue!=0? viewModel.gstValue!.toStringAsFixed(4) : 0.0}",style: AppTextStyle.subtitleBold1.copyWith(fontSize: AppFontSize.dp16,),),
                        VerticalSpacing.d2px(),
                        Text("Grand Total : ${viewModel.grandTotal!.toStringAsFixed(2)}",style: AppTextStyle.subtitleBold1.copyWith(fontSize: AppFontSize.dp16,),),
                      ],
                    ),
                  ],
                ) : Container(),
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
  CreatePaymentViewModel viewModelBuilder(BuildContext context) => CreatePaymentViewModel();

}

class DetailsWidget extends ViewModelWidget<CreatePaymentViewModel>{
  String? title;
  String? subTitle;
  DetailsWidget({this.title, this.subTitle});
  @override
  Widget build(BuildContext context, CreatePaymentViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!, style: AppTextStyle.subtitleBold2),
        VerticalSpacing.custom(value: 5),
        Text(subTitle!, style: AppTextStyle.bodyRegular.copyWith(fontSize: 16)),
      ],
    );
  }
}


class _SaveButton extends ViewModelWidget<CreatePaymentViewModel>{
  @override
  Widget build(BuildContext context, CreatePaymentViewModel viewModel) {

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Button(
              "Pay Now",
              key: Key("payBtn"),
              isLoading: viewModel.state == ViewState.Busy,
              onPressed:()async{
                if(viewModel.state != ViewState.Busy){
                  if(viewModel.userInfoFormKey.currentState?.validate() == true){
                    viewModel.kycDetails!=null ? viewModel.subscribeOnClick() : await showAlertDialog(context,viewModel);
                    // viewModel.subscribeOnClick();
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

  showAlertDialog(BuildContext context,CreatePaymentViewModel viewModel) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK",style: AppTextStyle.bodyMedium,),
      onPressed: () {
        navigationService.pop();
        navigationService.pushNamed(Routes.profile);
      },
    );

    Widget skipkButton = TextButton(
      child: Text("Skip",style: AppTextStyle.bodyMedium,),
      onPressed: () {
        navigationService.pop();
        viewModel.subscribeOnClick();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("BestPay",style: AppTextStyle.subheading),
      content: Text("Please Add your KYC",style: AppTextStyle.bodyMedium),
      actions: [
        skipkButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}