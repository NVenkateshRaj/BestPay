import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/images.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';
import 'intro_view_model.dart';

class IntroPage extends ViewModelBuilderWidget<IntroViewModel> {

  @override
  void onViewModelReady(IntroViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  IntroViewModel viewModelBuilder(BuildContext context) => IntroViewModel();

  @override
  Widget builder(BuildContext context, IntroViewModel viewModel, Widget? child) {
      return Scaffold(
        body: Column(
          children: [

            Flexible(
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: viewModel.controller,
                onPageChanged: (int index) {
                  viewModel.activeIndex = index;
                },
                children: <Widget>[
                  _IntroContent(image: Images.c1, title: "Save money",

                    description: "You can make all your bill payment like House Rent, Tuition Fees, Education Fees, etc through Credit Card, Net Banking and much more payment options",),

                  _IntroContent(image: Images.c2, title: "Payment Efficiently",
                    description: "Make your Utility and Bill Payments in few clicks using BestPay App",),

                  Container(
                    width: double.infinity,
                    color: AppColor.background,
                    padding: EdgeInsets.all(21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Image.asset(Images.appLogo, fit: BoxFit.fill, height: 85,),
                        VerticalSpacing.custom(value: 16),

                        Text("Welcome to BestPay", style: AppTextStyle.subHeaderMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 30),),

                        VerticalSpacing.custom(value: 16),

                        Text("Welcome to the world of operational efficiency! ",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.subtitleRegular.copyWith(height: 24 / 16)
                        ),

                        VerticalSpacing.custom(value: 35),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (viewModel.activeIndex != 2)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        SmoothPageIndicator(
                          controller: viewModel.controller,
                          count: 3,
                          effect: ExpandingDotsEffect(
                            dotColor: Color(0xffFFE6E5),
                            activeDotColor: AppColor.primary,
                            dotHeight: 12,
                            dotWidth: 12
                          ),
                          onDotClicked: (index){
                            viewModel.activeIndex = index;
                          }
                        ),

                        Button("NEXT", key: ValueKey("btnNext"), height: 38, icon: Icon(Icons.arrow_forward, size: 16, color: Colors.white,), onPressed: (){
                          viewModel.activeIndex++;
                          viewModel.controller.jumpToPage(viewModel.activeIndex);
                        })

                      ],
                    ),
                ),
              )
            else
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [

                      Button("Create Your FREE Account".toUpperCase(), key: ValueKey("btnRegister"), onPressed: (){
                        viewModel.onRegisterClick();
                      }),

                      VerticalSpacing.custom(value: 20),

                      Button.outline("Log into your account".toUpperCase(), key: ValueKey("btnLogin"), onPressed: (){
                        viewModel.onLoginClick();
                      }),

                    ],
                  ),
                ),
              )

          ],
        )
      );
  }
}

class _IntroContent extends StatelessWidget {

  String image;
  String title;
  String description;

  _IntroContent({ required this.image, required this.title, required this.description });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Flexible(child: Center(
            child:  Image.asset(image, fit: BoxFit.fitWidth,),
          )),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: AppTextStyle.subHeaderMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 30),)
          ),

          VerticalSpacing.custom(value: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(description,
                style: AppTextStyle.subtitleRegular.copyWith(height: 24 / 16)
            ),
          ),

          VerticalSpacing.custom(value: 30),

        ],
      ),
    );
  }
}