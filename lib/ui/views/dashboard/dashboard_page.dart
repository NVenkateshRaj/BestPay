import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/images.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/widgets/transction_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import '../../../locator.dart';
import '../../../router.dart';
import 'dashboard_view_model.dart';

class DashboardPage extends ViewModelBuilderWidget<DashboardViewModel> {
  @override
  void onViewModelReady(DashboardViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.inIt();
  }
  @override
  DashboardViewModel viewModelBuilder(BuildContext context) => DashboardViewModel();
  @override
  Widget builder(BuildContext context, DashboardViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColor.background
            )
          ),
          child: InkWell(
            onTap: (){
              navigationService.pushNamed(Routes.profile);
            },
            child:FractionallySizedBox(
                widthFactor: .5,
                child:SvgPicture.asset(Images.bottomProfile, color: AppColor.background)
            ),
          ),
        ),
        title:  Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("Best Pay",style: AppTextStyle.appBarTitle.copyWith(color: AppColor.white),),
        ),
      ),
      body:  SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: [1,2,3,4,5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.amber
                            ),
                            child: Center(child: Text('text $i', style: TextStyle(fontSize: 16.0),))
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 10),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                  )
              ),
              VerticalSpacing.custom(value: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RowWidget(onTap:()async{
                    await navigationService.pushNamed(Routes.payment);
                    viewModel.inIt();
                  },text: "Utility\nPayment",icon: Icon(Icons.event_note,color: AppColor.primary,size: 30,),),
                  _RowWidget(onTap:()async{
                    navigationService.pushNamed(Routes.cardPage);
                    viewModel.inIt();
                  },text: "Credit Card\nBills",icon: Icon(Icons.credit_card_sharp,color: AppColor.primary,size: 30,),),
                  _RowWidget(onTap:()async{
                    await navigationService.pushNamed(Routes.history);
                    viewModel.inIt();
                  },text: "History",icon: Icon(Icons.history,color: AppColor.primary,size: 30,),),
                  _RowWidget(onTap: ()=>print("Share Clicked"),text: "Share",icon: Icon(Icons.share,color: AppColor.primary,size: 30,),),
                ],
              ),
              VerticalSpacing.custom(value: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Recent Transcation",style: AppTextStyle.headerSemiBold.copyWith(fontSize: 24),),
                  viewModel.paymentList.length != 0 ? InkWell(
                    onTap: (){
                      navigationService.pushNamed(Routes.history);
                    },
                      child: Text("View All",style: AppTextStyle.headerSemiBold.copyWith(fontSize: 16),)
                  ) : Container(),
                ],
              ),
              VerticalSpacing.custom(value: 20.0),
              viewModel.paymentList.length != 0 ? ListView.builder(
                itemCount: viewModel.paymentList.length > 5 ? 5 : viewModel.paymentList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                return TranscationCard(viewModel.paymentList[index]);
              }): Center(child: Text("No Transcation Found",style: AppTextStyle.subtitleBold1,),)
            ],
          ),
        ),
      ),
    );
  }
}
class _RowWidget extends ViewModelWidget<DashboardViewModel>{

  Function? onTap;
  String? text;
  Icon? icon;

  _RowWidget({this.onTap,this.text,this.icon});

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap:(){
            onTap!();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: icon!,
              ),
              VerticalSpacing.d2px(),
              Text(text!,style: AppTextStyle.subtitleSemiBold.copyWith(color: AppColor.primary),textAlign: TextAlign.center,)
            ],
          ),
        ),
      ],
    );
  }
}







