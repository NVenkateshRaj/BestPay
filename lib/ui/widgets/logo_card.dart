import 'package:bestpay/core/res/colors.dart';
import 'package:flutter/material.dart';
class LogoCard extends StatefulWidget{
  Widget data;
  double? height;
  double? width;
  LogoCard({
    required this.data,
    this.height,
    this.width
  });
  @override
  _LogoCardState createState() => _LogoCardState();
}
class _LogoCardState extends State<LogoCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      alignment: Alignment.center,
      width: widget.height ?? 70,
      height: widget.width ?? 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.imageBorder, width: 1.98, ),
        color:AppColor.white,
      ),
      child: widget.data,
    );

  }
}