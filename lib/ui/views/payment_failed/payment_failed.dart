import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/images.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/locator.dart';
import 'package:bestpay/router.dart';
import 'package:bestpay/ui/views/payment_failed/paymentfailed_viewmodel.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

class PaymentFailed extends ViewModelBuilderWidget<PaymentFailedViewModel>{
  @override
  Widget builder(BuildContext context, PaymentFailedViewModel viewModel, Widget? child) {

    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          return false;
        },
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(Images.paymentFailed,height: 100,width: 70,),
                    HorizontalSpacing.d10px(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Text("Payment Failed",style: AppTextStyle.headerSemiBold,),
                          VerticalSpacing.d5px(),
                          Text("We regret the transaction was not successful due to the following possible reason:",style: AppTextStyle.bodyRegular.copyWith(fontWeight: FontWeight.w600),),
                          VerticalSpacing.d5px(),
                          Text("• Payment gateway seems to be down at this time",style: AppTextStyle.bodyRegular.copyWith(fontWeight: FontWeight.w600),)
                        ],
                      ),
                    )
                  ],
                ),
                VerticalSpacing.d15px(),

                Container(
                  margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
                  child:  Center(
                    child: Button(
                      "Back to Home",
                      key: Key("homebtn"),
                      isLoading: viewModel.state == ViewState.Busy,
                      onPressed:(){
                        if(viewModel.state != ViewState.Busy){
                         navigationService.popAllAndPushNamed(Routes.dashboard);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  PaymentFailedViewModel viewModelBuilder(BuildContext context) => PaymentFailedViewModel();

}