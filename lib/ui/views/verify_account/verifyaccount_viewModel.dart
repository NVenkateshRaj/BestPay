import 'dart:async';
import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import '../../../locator.dart';
import '../../../router.dart';
import '../../vgts_base_view_model.dart';

class VerifyAccountViewModel extends VGTSBaseViewModel{
  var uuid = Uuid();
  final GlobalKey<FormState> verifyAccountFormKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  NumberFormFieldController otpController = NumberFormFieldController(ValueKey("txtOtp"),required: true);
  String _screenFrom = "";
  String _phoneNumber = "";
  int counter = 30;
  UserDetails userDetails = UserDetails();
  String _counterValue = "30";
  String get counterValue => _counterValue;
  late String sessionId, phoneNumber;
  String get screenFrom => _screenFrom;
  String verificationId = "";
  Timer? _timer;
  int _start = 30;
  int get start =>_start;
  set start(int value){
    _start = value;
    notifyListeners();
  }


  init({data}){
    if(data!=null){
      _screenFrom = data['screenFrom'];
      _phoneNumber = data['phoneNumber'];
      if(_screenFrom == Routes.register || _screenFrom == Routes.forgotPassword ||_screenFrom == Routes.profile){
        userDetails = data['userDetails'];
      }
      verifyPhoneNumber();
    }

    startTimer();
  }


  startTimer() {
    counter = 30;
    var oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (_timer) {
        if (counter == 0) {
          counter = 0;
          _counterValue = "00";
          _timer.cancel();
        } else {
          if (counter < 11) {
            counter--;
            _counterValue = "0" + counter.toString();
          } else {
            counter--;
            _counterValue = counter.toString();
          }
        }
        notifyListeners();
      },
    );
  }

  verifyBtnClick()async{
    start = 0;
    setState(ViewState.Busy);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpController.text);
    await signInWithPhoneAuthCredential(phoneAuthCredential);
    setState(ViewState.Idle);
    notifyListeners();
  }

  void verifyPhoneNumber()async{
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$_phoneNumber",
      verificationCompleted: (phoneAuthCredential) async {
      },
      verificationFailed: (verificationFailed) async {
        print(verificationFailed);
      },
      codeSent: (verificationId, resendingToken) async {
        this.verificationId = verificationId;
        print(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        this.verificationId = verificationId;
        print(verificationId);
      },
    );
  }

   signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential)async{
    try {
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);
      if(authCredential.user != null){
        if( screenFrom == Routes.forgotPassword || screenFrom == Routes.logIn){
          var arguments = {
            'screenFrom': Routes.forgotPassword,
            'phoneNumber' : _phoneNumber,
            'userDetails' : userDetails,
          };
          navigationService.pushNamed(Routes.recoverPassword,arguments: arguments);
        }
        else{
          userCreate();
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  resendOtp() async {
    _timer!.cancel();
    otpController.clear();
    startTimer();
  }

  userCreate()async{
    String userId = uuid.v4();
    try{
      userDetails.userId = userId;
      await dataBaseService.createUserData(userDetails);
      preferenceService.setBearerToken(userId);
      preferenceService.setUserPhone(userDetails.phoneNumber!);
      navigationService.popAllAndPushNamed(Routes.dashboard);
    }catch(e){
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }
}