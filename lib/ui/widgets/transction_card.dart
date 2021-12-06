import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/model/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'decoration.dart';

class TranscationCard extends StatelessWidget {

  final PaymentCollection payment;


  TranscationCard(this.payment);

  @override
  Widget build(BuildContext context) {
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
                  Text("₹ ${payment.amount!}",style: AppTextStyle.subtitleBold1.copyWith(fontSize: 18),),
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