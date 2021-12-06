import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:flutter/material.dart';

class ErpOneTabBar extends StatefulWidget {

  final List<Widget>? itemList;
  final Function(int index)? onChange;
  final int? initialIndex;
  final List<Widget>? children;

  ErpOneTabBar({this.itemList, this.initialIndex, this.onChange, this.children = const []});

  @override
  _ErpOneTabBarState createState() => _ErpOneTabBarState();
}

class _ErpOneTabBarState extends State<ErpOneTabBar> with SingleTickerProviderStateMixin {

  //String get metalName => widget.itemList![widget.initialIndex!];

  TabController? controller;

  @override
  void initState() {
    controller = new TabController(length: widget.itemList!.length, initialIndex: widget.initialIndex!, vsync: this);

    controller!.addListener(() {
      setState(() {
        widget.onChange!(controller!.index);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0xFFFDF7EA)
          ),
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: controller,
            onTap: (int index) {
              widget.onChange!(index);
            },
            isScrollable: true,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xFFFF8180)
            ),
            labelColor: AppColor.white,
            labelStyle: AppTextStyle.bodyRegular.copyWith(fontWeight: FontWeight.w700, height: 17.05 / 14),
            unselectedLabelStyle: AppTextStyle.bodyRegular,
            unselectedLabelColor: AppColor.black,
            tabs: [
              ...widget.itemList!.map((e) => Container(
                child: e,
              ))
            ],
          ),
        ),

        Flexible(
            child: SafeArea(
              child: TabBarView(
                controller: controller,
                children: widget.children!,
                physics: ClampingScrollPhysics(),
              ),
            )
        ),

      ],
    );
  }

}