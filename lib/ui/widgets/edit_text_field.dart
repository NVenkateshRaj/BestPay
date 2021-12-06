import 'package:bestpay/core/res/colors.dart';
import 'package:bestpay/core/res/images.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';

TextStyle _errorTextStyle = TextStyle(fontSize: 14, fontFamily: AppStyle.fontFamily, fontWeight: FontWeight.w400, color: AppColor.error,);
TextStyle _labelTextStyle = TextStyle(fontSize: 16, fontFamily: AppStyle.fontFamily, fontWeight: FontWeight.w700, color: Color(0xff001533),);
TextStyle _bodyTextStyle = TextStyle(fontSize: 16, fontFamily: AppStyle.fontFamily, fontWeight: FontWeight.w500, color: Color(0xff202124),);
TextStyle _hintTextStyle = TextStyle(fontSize: 16, fontFamily: AppStyle.fontFamily, fontWeight: FontWeight.w500, color: Color(0xffbdc1c6),);

BorderRadius _borderRadius = BorderRadius.circular(6.0);

class EditTextField extends StatefulWidget {

  FormFieldController controller;

  String label;
  String? subTitle;
  TextStyle? textStyle;
  TextAlign textAlign;

  EdgeInsets? margin;
  EdgeInsets? padding;

  TextInputAction textInputAction;

  String? placeholder;
  Widget? prefixIcon;
  Widget? suffixIcon;

  String? prefixText;
  String? counterText;

  bool autoFocus = false;
  bool isPasswordField = false;

  bool enabled = true;

  ValueChanged<String>? onChanged = (terms) {};
  ValueChanged<String>? onSubmitted = (terms) {};

  EditTextField(this.label,
      this.controller, {
        this.margin = EdgeInsets.zero,
        this.onSubmitted,
        this.onChanged,
        this.subTitle,
        this.autoFocus = false,
        this.enabled = true,
        this.prefixText,
        this.placeholder,
        this.prefixIcon,
        this.padding,
        this.textAlign = TextAlign.left,
        this.textStyle,
        this.textInputAction = TextInputAction.next,
        this.suffixIcon,
        this.counterText
      });


  EditTextField.password(this.label,
      this.controller,
      { this.margin = EdgeInsets.zero,
        this.onSubmitted,
        this.onChanged,
        this.enabled = true,
        this.autoFocus = false,
        this.prefixText,
        this.placeholder,
        this.prefixIcon,
        this.padding,
        this.textAlign = TextAlign.left,
        this.textInputAction = TextInputAction.next,
        this.suffixIcon }) {
    isPasswordField = true;
  }



  @override
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {

  bool isVisible = false;
  bool isFocused = false;

  @override
  void initState() {

    widget.controller.focusNode..addListener(() {
     if( widget.controller.focusNode.hasFocus){
       isFocused = true;
     }
     else{
       isFocused = false;
     }
      setState(() {});
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {



    return new Container(
      margin: widget.margin,
      child: FormField<String>(
        initialValue: widget.controller.text,
        validator: (value) {

          if (!widget.controller.required && widget.controller.text.isEmpty) {
            return null;
          }

          if ((widget.controller.required || widget.controller.text.isNotEmpty) && widget.controller.validator != null) {
            return widget.controller.validator!(value);
          }

          return null;
        },
        builder: (FormFieldState state) {

          if (widget.controller.textEditingController.hasListeners) {
            widget.controller.textEditingController.removeListener(() { });
          }

          widget.controller.textEditingController.addListener(() {
            state.reset();
            state.didChange(widget.controller.text);
          });

          return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                if (state.hasError)
                  Text(
                    state.errorText ?? '',
                    style: _errorTextStyle,
                  )
                else
                  Padding(
                    padding:EdgeInsets.only(left:4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.label,
                                style: _labelTextStyle,
                              ),
                              widget.subTitle == null ?Container():Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: Text("${widget.subTitle}",style:AppTextStyle.bodyMedium.copyWith(fontSize:12,color:AppColor.green)),
                              ),
                              if (widget.controller.required)
                                Text("* ",
                                  style: _labelTextStyle.copyWith(color:AppColor.text),
                                ),
                            ],
                          ),
                        ),



                      ],
                    ),
                  ),

                Padding(
                  padding: EdgeInsets.only(top:4),
                ),

                TextField(
                    key: widget.controller.fieldKey,
                    controller: widget.controller.textEditingController,
                    enableInteractiveSelection: true,
                    obscureText: widget.isPasswordField && !isVisible ? true : false,
                    textInputAction: widget.textInputAction,
                    textAlign: widget.textAlign,
                    style: widget.textStyle ?? _bodyTextStyle,
                    focusNode: widget.controller.focusNode,
                    autofocus: widget.autoFocus,
                    cursorColor:AppColor.black,
                    cursorWidth:1.5,
                    onChanged: (value) {
                      state.reset();
                      state.didChange(value);
                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                    },
                    onSubmitted: (value) {
                      if (widget.onSubmitted != null) {
                        widget.onSubmitted!(value);
                      }
                    },
                    enabled: widget.enabled,
                    maxLength: widget.controller.maxLength,
                    maxLines: widget.isPasswordField ? 1 : widget.controller.maxLines,
                    minLines: widget.controller.minLines,

                    inputFormatters: widget.isPasswordField || widget.controller.textInputType == TextInputType.emailAddress ? [
                      FilteringTextInputFormatter.deny(new RegExp('[\\ ]')),
                    ] : widget.controller.inputFormatter,

                    decoration: InputDecoration(
                      fillColor: !widget.enabled ? Color(0xffFDF8EC) : state.hasError? AppColor.errorBackgroundColor : isFocused? AppColor.focusBackgroundColor : AppColor.white,
                      filled: true,
                      contentPadding: widget.padding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 12),

                      border: _outlineInputBorder,
                      enabledBorder: _outlineInputBorder,
                      disabledBorder: _outlineInputBorder,
                      focusedBorder: _focusedInputBorder,
                      errorBorder: _errorInputBorder,
                      errorStyle: _errorTextStyle,

                      hintText: widget.placeholder,
                      hintStyle: _hintTextStyle,
                      focusColor: AppColor.focusBackgroundColor,
                      suffixIconConstraints: BoxConstraints(minWidth: 15, maxHeight: 20),
                      prefixIconConstraints: BoxConstraints(minWidth: 15, maxHeight: 20),
                      prefix: widget.prefixText == null ? null : Text("${widget.prefixText} ", style: _bodyTextStyle,),
                      prefixIcon: widget.prefixIcon == null ? null : widget.prefixIcon,
                      suffixIcon: widget.isPasswordField ? _buildPasswordEyeIcon() : widget.suffixIcon != null ? widget.suffixIcon : null,
                      counterText: widget.counterText != null ? widget.counterText : "",
                    ),
                    keyboardType: widget.controller.textInputType,
                    textCapitalization: widget.controller.textCapitalization
                ),

              ]
          );
        },
      ),
    );
  }

  Widget _buildPasswordEyeIcon(){
    return IconButton(
      padding: EdgeInsets.zero,
        icon: SvgPicture.asset(
          isVisible ? Images.passShow : Images.passHidden, height: 18, width: 18,
        ),
        onPressed: () {
          isVisible = !isVisible;
          setState(() {});
        }
    );
  }


  void dispose() {
    widget.controller.focusNode.removeListener(() { });

    super.dispose();
  }

}


InputBorder _outlineInputBorder = OutlineInputBorder(
  borderRadius: _borderRadius,
  borderSide: BorderSide(color: AppColor.borderColor, width:1),
);

InputBorder _focusedInputBorder = OutlineInputBorder(
  borderRadius: _borderRadius,
  borderSide: BorderSide(color: AppColor.borderColor, width:1),
);

InputBorder _errorInputBorder = OutlineInputBorder(
  borderRadius: _borderRadius,
  borderSide: BorderSide(color: AppColor.borderColor, width:1),
);
