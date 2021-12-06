import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/model/customer.dart';
import 'package:bestpay/model/payment.dart';
import 'package:bestpay/ui/shared/tabbar.dart';
import 'package:bestpay/ui/views/utility_payment/payment/payment_viewmodel.dart';
import 'package:bestpay/ui/widgets/decoration.dart';
import 'package:bestpay/ui/widgets/logo_card.dart';
import 'package:bestpay/ui/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../../../locator.dart';
import '../../../../router.dart';

class PaymentPage extends ViewModelBuilderWidget<PaymentViewModel>{

  @override
  void onViewModelReady(PaymentViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.onInIt();
  }
  @override
  Widget builder(BuildContext context, PaymentViewModel viewModel, Widget? child) {
    return DefaultTabController(
      length: 4,
      initialIndex: viewModel.tabCurrentIndex,
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: AppColor.primary,
          title: Text("Utility Payment",style: AppTextStyle.appBarTitle.copyWith(color:AppColor.white),),
          centerTitle: true,
          leading: InkWell(
            onTap: (){
              navigationService.pop();
            },
            child: Icon(Icons.arrow_back,color: AppColor.white,),
          ),
        ),
        body: viewModel.mainPageLoading  ?  LoadingScreen() : ErpOneTabBar(
          initialIndex: viewModel.tabCurrentIndex,
          itemList: [
            _VGTSTab("Payments"),
            _VGTSTab("Transcations"),
            _VGTSTab("Manage Beneficiaries"),
          ],
          onChange: (int index){
            viewModel.tabCurrentIndex = index;
            viewModel.tabChange(index);
            viewModel.notifyListeners();
          },
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child:_Payments(),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child:_Transcatoins(),
            ) ,
           Container(
              margin: EdgeInsets.all(16),
              child:_Customers(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await navigationService.pushNamed(Routes.createCustomer);
            viewModel.onInIt();
          },
        ),
      ),
    );
  }
  @override
  PaymentViewModel viewModelBuilder(BuildContext context)=> PaymentViewModel();
}
class _VGTSTab extends StatelessWidget {
  String title;
  _VGTSTab(this.title,);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Text(title),
    );
  }
}
class _Payments extends ViewModelWidget<PaymentViewModel>{
  @override
  Widget build(BuildContext context, PaymentViewModel viewModel) {
    return viewModel.customerList.length != 0 ? Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: viewModel.customerList.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return _PaymentItemCard(viewModel.customerList[index],false);
                }
            ),
        ),
      ],
    ) : Center(child: Text("No Payments Found",style: AppTextStyle.subtitleBold1)) ;
  }
}



class _Transcatoins extends ViewModelWidget<PaymentViewModel>{
  @override
  Widget build(BuildContext context, PaymentViewModel viewModel) {
    return  viewModel.paymentList.length != 0 ? Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: viewModel.paymentList.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return _TranscationCard(viewModel.paymentList[index]);
              }
          ),
        ),
      ],
    ) : Center(child: Text("No Payments Found",style: AppTextStyle.subtitleBold1)) ;
  }
}


class _Customers extends ViewModelWidget<PaymentViewModel>{
  @override
  Widget build(BuildContext context, PaymentViewModel viewModel) {
    return viewModel.customerList.length != 0 ?Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: viewModel.customerList.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return _PaymentItemCard(viewModel.customerList[index],true);
                }
            ),
        ),
      ],
    ) : Center(child: Text("No Payments Found",style: AppTextStyle.subtitleBold1)) ;
  }
}


class _PaymentItemCard extends ViewModelWidget<PaymentViewModel> {

  CustomerCollection customer;
  final bool isEdit;

  _PaymentItemCard(this.customer,this.isEdit);

  @override
  Widget build(BuildContext context, PaymentViewModel viewModel) {

    return InkWell(
      onTap: ()async{
        var arguments = {"customer": customer};
        isEdit ? await navigationService.pushNamed(Routes.createCustomer,arguments: arguments) : await navigationService.pushNamed(Routes.createPayment , arguments: arguments);
        viewModel.onInIt();
      },
      child:  DecorationContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoCard(
              data:Text(customer.customerName!.substring(0,1).toUpperCase(),style: AppTextStyle.headerSemiBold,)
            ),
            HorizontalSpacing.custom(value: 14.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${customer.customerName}",style: AppTextStyle.subtitleBold1,),
                  VerticalSpacing.custom(value: 6.0),
                  Text("Account Number : ${customer.accountNumber}",style: AppTextStyle.bodyRegular,),
                  VerticalSpacing.custom(value: 6.0),
                  Text("IFSC: ${customer.ifscCode}",style: AppTextStyle.bodyRegular,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TranscationCard extends ViewModelWidget<PaymentViewModel> {

  PaymentCollection payment;

  _TranscationCard(this.payment);
  @override
  Widget build(BuildContext context, PaymentViewModel viewModel) {
    return InkWell(
      onTap: ()async{
      },
      child: DecorationContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(payment.customerName!,style: AppTextStyle.subtitleBold1.copyWith(fontSize: 18),),
                  VerticalSpacing.custom(value: 6.0),
                  Text(payment.accountNumber!,style: AppTextStyle.bodyRegular.copyWith(fontSize: 16),),
                  VerticalSpacing.custom(value: 6.0),
                  Text("Failed",style: AppTextStyle.bodyRegular.copyWith(color: AppColor.red,),),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("₹ ${payment.total!}",style: AppTextStyle.subtitleBold1.copyWith(fontSize: 18),),
                  VerticalSpacing.custom(value: 6.0),
                  Text(payment.date!,style: AppTextStyle.bodyRegular.copyWith(fontSize: 16),),
                  VerticalSpacing.custom(value: 6.0),
                  Text(payment.time!,style: AppTextStyle.bodyRegular,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}