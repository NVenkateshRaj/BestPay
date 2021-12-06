import 'package:bestpay/core/enum/viewstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import '../../../locator.dart';
import '../../../router.dart';
import '../../vgts_base_view_model.dart';
class LogInViewModel extends VGTSBaseViewModel{
  final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  PhoneFormFieldController phoneNumberController = PhoneFormFieldController(ValueKey("txtPhone"), requiredText: "Please Enter Mobile Number",);
  TextFormFieldController passwordController = TextFormFieldController(ValueKey("txtPassword"), requiredText: "Please Enter Password",required: true,);
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  forgotPasswordOnClick()async{
    navigationService.pushNamed(Routes.forgotPassword);
  }

  logInOnClick()async{
    setState(ViewState.Busy);
    var data = await dataBaseService.getUserList(phoneNumberController.text, password: passwordController.text);
    if(data!=null){
      preferenceService.setBearerToken(data['userId']);
      preferenceService.setUserPhone(data['phoneNumber']);
      navigationService.popAllAndPushNamed(Routes.dashboard);
    }
    else{
      Fluttertoast.showToast(msg: "Phone Number or Password incorrect");
    }
    setState(ViewState.Idle);
    notifyListeners();
  }

  Future<void> handleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      var arguments = {
        "name":googleUser!.displayName,
        "email":googleUser.email,
      };
      navigationService.popAllAndPushNamed(Routes.register,arguments:arguments );
    } catch (error) {
      print(error);
    }
  }
}
