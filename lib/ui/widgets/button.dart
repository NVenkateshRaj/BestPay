import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/spacing.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TextStyle _buttonTextStyle = TextStyle(fontSize: 15, fontFamily: AppStyle.fontFamily, fontWeight: FontWeight.w500, color: AppColor.white, letterSpacing: 1.5);
TextStyle _outlineTextStyle = TextStyle(fontSize: 15, fontFamily: AppStyle.fontFamily, fontWeight: FontWeight.w500, color: AppColor.buttonColor, letterSpacing: 1.5);

class Button extends StatelessWidget {

  final Key key;
  final String text;
  TextStyle? textStyle;
  final EdgeInsets? padding;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final Color color;
  final Color borderColor;
  final BorderRadius? borderRadius;
  final bool disabled;
  Widget? icon = Container();
  bool isLoading = false;

  bool isOutline = false;

  Button(this.text, {required this.key, this.textStyle, this.width =82, this.height = 48, required this.onPressed,
    this.color = AppColor.buttonColor, this.borderColor = AppColor.buttonColor, this.borderRadius, this.disabled = false,this.isLoading=false, this.icon, this.padding});

  Button.outline(this.text, {required this.key, this.textStyle, this.width = 82, this.height = 48, required this.onPressed,
    this.color = AppColor.background, this.borderColor = AppColor.buttonColor, this.borderRadius, this.disabled = false, this.icon, this.padding}){
    this.isOutline = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: key,
      elevation:0.0,
      // minWidth: width.sp,
      height: height,
      minWidth: width,
      onPressed: disabled ? null : onPressed,
      color: disabled ? color.withOpacity(0.4) : color,
      padding: padding == null ? EdgeInsets.symmetric(vertical:12, horizontal:16) : padding,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: disabled ? borderColor.withOpacity(0.1) : borderColor, width: 1.0),
        borderRadius: borderRadius ?? new BorderRadius.all(Radius.circular(4)),
       ),
      child: isLoading ? SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(strokeWidth:2,  valueColor: AlwaysStoppedAnimation(AppColor.white),),
      ) :
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(text,
            style: textStyle == null ? isOutline ? _outlineTextStyle : _buttonTextStyle : textStyle, maxLines: 1, overflow: TextOverflow.fade,
          ),

          if(icon != null ) HorizontalSpacing.custom(value:8.0),

          icon ?? Container(),

        ],
      ),
    );
  }

}