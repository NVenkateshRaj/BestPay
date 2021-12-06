import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/widgets/transction_card.dart';
import 'package:bestpay/ui/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';
import 'history_viewmodel.dart';

class HistoryPage extends ViewModelBuilderWidget<HistoryViewModel>{

  @override
  void onViewModelReady(HistoryViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.inIt();
  }
  @override
  Widget builder(BuildContext context, HistoryViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text("History",style: AppTextStyle.appBarTitle.copyWith(color:AppColor.white),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            navigationService.pop();
          },
          child: Icon(Icons.arrow_back,color: AppColor.white,),
        ),
      ),

      body: viewModel.mainPageLoading ? LoadingScreen() :  Container(
        margin: EdgeInsets.all(16.0),
        child:  _Transcatoins(),
      ),
    );
  }
  @override
  HistoryViewModel viewModelBuilder(BuildContext context) => HistoryViewModel();
}

class _Transcatoins extends ViewModelWidget<HistoryViewModel>{
  @override
  Widget build(BuildContext context, HistoryViewModel viewModel) {
    return  viewModel.paymentList.length !=0 ? Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: viewModel.paymentList.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return TranscationCard(viewModel.paymentList[index]);
                }
            ),

        ),
      ],
    ) : Center(child: Text("No Payment Found",style: AppTextStyle.subtitleBold1,),);
  }
}

