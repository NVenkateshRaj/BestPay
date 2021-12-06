import 'package:flutter/cupertino.dart';

class DecorationContainer extends StatelessWidget{

   Widget? child;


  DecorationContainer({this.child});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: Color(0xffFBF0DA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffF5DAA3), width: 0.6)
      ),
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(14),
      child: child,
    );
  }

}