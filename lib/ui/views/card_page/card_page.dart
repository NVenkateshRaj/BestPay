import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/widgets/decoration.dart';
import 'package:bestpay/ui/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import '../../../locator.dart';
import '../../../router.dart';
import 'cardpage_viewmodel.dart';

class CardPage extends ViewModelBuilderWidget<CardPageViewModel>{

  @override
  void onViewModelReady(CardPageViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.inIt();
  }
  @override
  Widget builder(BuildContext context,CardPageViewModel viewModel, Widget? child) {

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar:  AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            navigationService.pop();
          },
          child: Icon(Icons.arrow_back,color: AppColor.white,),
        ),
        title:  Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("Credit Card",style: AppTextStyle.appBarTitle.copyWith(color: AppColor.white),),
        ),
      ),
      body: viewModel.state ==ViewState.Idle ? viewModel.cardList.length !=0 ? SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.cardList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return DecorationContainer(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _richText(title:"Name : ",content:  viewModel.cardList[index].name!),
                        VerticalSpacing.custom(value: 6.0),
                        _richText(title:"CardNumber : ",content:  viewModel.cardList[index].cardNumber!),
                        VerticalSpacing.custom(value: 6.0),
                        _richText(title:"BankName : ",content:  viewModel.cardList[index].bankName!),
                        VerticalSpacing.custom(value: 6.0),
                        _richText(title:"CardType : ",content:  viewModel.cardList[index].cardType!),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       InkWell(
                           child: Icon(Icons.delete,color: AppColor.primary,),
                         onTap: ()async{
                             await viewModel.deleteCard(viewModel.cardList[index].cardId!);
                             viewModel.notifyListeners();
                         },
                       ),
                        VerticalSpacing.d40px(),
                        InkWell(
                          onTap: (){
                            print("Pay Now Click");
                          },
                          child: Text("PayNow",style: AppTextStyle.bodyRegular.copyWith(color: AppColor.red,),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                );
              }),
            ],
          ),
        ) ): Center(child:Text("No Card Found",style: AppTextStyle.subtitleBold1,)) : LoadingScreen(),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
          await navigationService.pushNamed(Routes.createCreditCard);
          viewModel.inIt();
        },
      ),
    );
  }

  Widget _richText({String? title,String? content}){
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: title,style: AppTextStyle.subtitleBold1.copyWith(fontSize: 18)),
          TextSpan(
            text: content,
            style: AppTextStyle.bodyRegular.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
  @override
  CardPageViewModel viewModelBuilder(BuildContext context) => CardPageViewModel();

}

