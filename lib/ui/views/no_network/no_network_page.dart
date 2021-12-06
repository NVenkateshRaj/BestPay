import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/images.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:stacked/stacked.dart';

import 'nonetwork_viewmodel.dart';

class NoNetWorkPage extends ViewModelBuilderWidget<NoNetworkViewModel>{
  @override
  void onViewModelReady(NoNetworkViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    viewModel.init();
  }
  @override
  Widget builder(BuildContext context, NoNetworkViewModel viewModel, Widget? child) {

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: SvgPicture.asset(Images.noNetwork,fit: BoxFit.cover,),
            ),
            VerticalSpacing.d16px(),
            Text("No Network Found",style: AppTextStyle.subtitleBold,),
            Text("Sorry for the inconvenience. Because of some technical issue we are not able to process the request.Please try any of the below"),
            VerticalSpacing.d2px(),
            Text("1.Check your internet connection . It should be ON."),
            VerticalSpacing.d2px(),
            Text("2.Retry after 10 mins or "),
            VerticalSpacing.d2px(),
            Text("3.Restart the application or"),
            VerticalSpacing.d2px(),
            Text("4.Restart the mobile."),
            VerticalSpacing.d2px(),
          ],
        ),
      ),
    );
  }
  @override
  NoNetworkViewModel viewModelBuilder(BuildContext context) => NoNetworkViewModel();
}
