
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'fontsize.dart';

class AppStyle {
  static final String fontFamily = "ProximaNova";
  static final ThemeData appTheme = ThemeData(
    primaryColor: AppColor.primary,
    primaryColorDark: AppColor.primaryDark,
    accentColor: AppColor.accent,
    dividerColor: AppColor.divider,
    unselectedWidgetColor: AppColor.borderColor,
    canvasColor: AppColor.white,
    //primarySwatch: _primaryBlue,
   // brightness: Brightness.dark,
    indicatorColor: AppColor.primaryDark,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor:  AppColor.primaryBlue,
      selectionColor: AppColor.primaryBlue.withOpacity(0.3),
      selectionHandleColor:  AppColor.primaryBlue,
    ),
    textTheme: TextTheme(
        button: TextStyle(color: AppColor.primary,fontSize:16)
    ),
    primaryIconTheme: const IconThemeData.fallback().copyWith(
        color: AppColor.black
    ),
    appBarTheme: AppBarTheme().copyWith(
      iconTheme: IconThemeData(
        color: AppColor.black,
      ),
     // color: AppColor.white,
      //brightness: Brightness.dark,
      titleSpacing: 0,
      centerTitle: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.primary
    ),
    backgroundColor: AppColor.background,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: AppColor.background,
  );
  static final List<BoxShadow> cardShadow = [
    BoxShadow(color: Colors.black.withOpacity(0.08), spreadRadius:0, blurRadius:4),
  ];
  static final Widget customDivider = SizedBox(height: 1,child: Divider(color: AppColor.primaryDivider, thickness:1.2,),);
  static final List<BoxShadow> mildCardShadow = [
    BoxShadow(color: AppColor.black.withOpacity(0.2), spreadRadius: 0.5, blurRadius: 1),
  ];
  static List<Shadow> textShadow = <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
      color: Colors.black12,
    ),
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Colors.black12,
    ),
  ];
}

class AppTextStyle {
  static TextStyle appBarTitle = TextStyle(
    fontSize: AppFontSize.dp20,
    fontWeight: FontWeight.w800,
    color: AppColor.text,
  );
  static TextStyle headerExtraBold = TextStyle(
      fontSize: AppFontSize.dp30,
      fontWeight: FontWeight.w800,
      color: AppColor.text
  );
  static TextStyle headerMedium = TextStyle(
      fontSize: AppFontSize.dp28,
      fontWeight: FontWeight.w400,
      color: AppColor.text
  );
  static TextStyle headerSemiBold = TextStyle(
      fontSize: AppFontSize.dp28,
      fontWeight: FontWeight.w600,
      color: AppColor.text
  );
  static TextStyle subHeaderBold = TextStyle(
      fontSize: AppFontSize.dp24,
      fontWeight: FontWeight.w700,
      color: AppColor.text
  );
  static TextStyle subHeaderMedium = TextStyle(
      fontSize: AppFontSize.dp24,
      fontWeight: FontWeight.w400,
      color: AppColor.text
  );
  static TextStyle titleMedium = TextStyle(
      fontSize: AppFontSize.dp20,
      fontWeight: FontWeight.w400,
      color: AppColor.text
  );
  static TextStyle subtitleBold3= TextStyle(
      fontSize: AppFontSize.dp18,
      fontWeight: FontWeight.w700,
      color: AppColor.text
  );
  static TextStyle subtitleRegular = TextStyle(
      fontSize: AppFontSize.dp16,
      fontWeight: FontWeight.w400,
      color: AppColor.text
  );
  static TextStyle subtitleSemiBold = TextStyle(
      fontSize: AppFontSize.dp16,
      fontWeight: FontWeight.w600,
      color: AppColor.text
  );
  static TextStyle bodySemiBold = TextStyle(
      fontSize: AppFontSize.dp16,
      fontWeight: FontWeight.w600,
      color: AppColor.text
  );
  static  TextStyle captionRegular = TextStyle(
    fontSize: AppFontSize.dp12,
    fontWeight: FontWeight.w400,
    color: AppColor.text,
  );
  static  TextStyle captionMedium = TextStyle(
    fontSize: AppFontSize.dp12,
    fontWeight: FontWeight.w400,
    color: AppColor.text,
  );
  static TextStyle overLine = TextStyle(
    fontSize: AppFontSize.dp10,
    fontWeight: FontWeight.w500,
    color: AppColor.secondaryText,
  );
  static TextStyle button2 = TextStyle(
      fontSize: AppFontSize.dp12,
      fontWeight: FontWeight.w600,
      color: AppColor.primary
  );
  static TextStyle subheading=TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSize.dp16,
    color: AppColor.text,
  );
  static TextStyle redText=TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: AppFontSize.dp16,
    color: AppColor.redColor,
  );
  static TextStyle headExtraBold=TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: AppFontSize.dp19,
    color: AppColor.white,
  );
  static TextStyle blackHeadExtraBold=TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: AppFontSize.dp16,
    color: AppColor.text,
  );
  static  TextStyle bodyMedium=TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSize.dp13,
    color: AppColor.text,
  );
  static TextStyle bodyRegular=TextStyle(
    fontWeight:FontWeight.w400,
    fontSize: AppFontSize.dp14,
     color: AppColor.text,
  );
  static TextStyle subtitleBold=TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSize.dp14,
    color: AppColor.text,
  );
  static TextStyle subtitleBold1=TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSize.dp20,
    color: AppColor.titleBlack,
  );
  static TextStyle subtitleBold2=TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSize.dp16,
    color: AppColor.titleBlack,
  );
  static TextStyle subtitleMedium=TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSize.dp14,
    color: AppColor.text,
  );
  static TextStyle textMedium=TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSize.dp14,
    color: AppColor.black,
  );
  static TextStyle subTitle=TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSize.dp16,
    color: AppColor.titleBlack,
  );
  static TextStyle bodyAppMedium=TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppFontSize.dp12,
    color: AppColor.text,
  );
}