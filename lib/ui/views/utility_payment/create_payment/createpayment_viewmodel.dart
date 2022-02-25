import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/core/res/styles.dart';
import 'package:bestpay/model/customer.dart';
import 'package:bestpay/model/kyclist.dart';
import 'package:bestpay/model/payment.dart';
import 'package:bestpay/model/purpose.dart';
import 'package:bestpay/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import '../../../../locator.dart';
import '../../../vgts_base_view_model.dart';

class CreatePaymentViewModel extends VGTSBaseViewModel{

  NumberFormFieldController amountController = NumberFormFieldController(ValueKey("txtamount"),required: true);
  DropdownFieldController<PurposeType> purposeController = DropdownFieldController<PurposeType>(ValueKey("dPurpose"), keyId: "id", valueId: "purpose",required: true);
  DropdownFieldController<TranscationType> transcationController = DropdownFieldController<TranscationType>(ValueKey("dTranscationType"), keyId: "id", valueId: "type",required: true);
  var uuid = Uuid();
  Razorpay _razorpay = Razorpay();
  CustomerCollection customer = CustomerCollection();
  List<PurposeType> purposeType = [];
  double? gstValue;
  double? totalAmount;
  double? grandTotal;
KYCDetails? kycDetails;
  List<BearerType> bearerType = [
    BearerType(id: 1,bearer: "Receiver"),
    BearerType(id: 2,bearer: "Sender"),
  ];

  List<TranscationType> transcationType = [
    TranscationType(id: 1,type: "Instant Pay",percentage: 2.0),
    TranscationType(id: 2,type: "Next Day",percentage: 0.9),
  ];

  final GlobalKey<FormState> userInfoFormKey = GlobalKey<FormState>();

  inIt({data})async{
    if(data!=null){
      customer = data['customer'];
    }
    getPurposeList();
    transcationController.list = transcationType;
    getKycDetails();
    notifyListeners();
  }

  getKycDetails()async{
    kycDetails = await dataBaseService.getKYCList();
    notifyListeners();
  }

  getPurposeList()async{
    purposeType = await dataBaseService.getPurposeList();
    purposeController.list = purposeType;
    notifyListeners();
  }

   openCheckout(BuildContext context) async{
    var options = {
      "key": "bysz5K4Cm0cW2vGi64Wo7QPe",
      "amount": num.parse(amountController.text)*100,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "external": {
        "wallets": ["paytm"]
      },
      "timeout":0.1,
    };
    try{
      _razorpay.open(options);
     await subscribeOnClick();
      // showAlertDialog1(context);
      navigationService.pushNamed(Routes.paymentFailed);
    }catch(e){
      print(e.toString());
    }
  }

  showAlertDialog1(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK",style: AppTextStyle.bodyMedium,),
      onPressed: () {
        navigationService.pop();
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("BestPay",style: AppTextStyle.subheading),
      content: Text("Payment Failed",style: AppTextStyle.bodyMedium),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  subscribeOnClick()async{
    setState(ViewState.Busy);
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    PaymentCollection paymentCollection = PaymentCollection(
      customerName: customer.customerName,
      nickName: customer.nickName,
      phoneNumber: customer.phoneNumber,
      accountNumber: customer.accountNumber,
      paymentId: uuid.v4().toString(),
      purpose: purposeController.value!.purpose,
      amount: amountController.text,
      total: grandTotal!.toStringAsFixed(2),
      date: formatter.format(now),
      createdAt: Timestamp.now(),
      time: DateFormat.jm().format(now),
    );
    try{
      await dataBaseService.createPayment(paymentCollection);
      setState(ViewState.Idle);
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

  convertAmount(String amount){
    if(amount.isNotEmpty){
      if(transcationController.value != null){
        print("if");
        print(transcationController.value!.percentage!);
        print(double.parse(amount) / (2.0.toDouble() *  100));
        totalAmount = (double.parse(amount) / (transcationController.value!.percentage! * 100));
        print(totalAmount);
        gstValue = totalAmount! /(18 * 100);
      }
    }
    grandTotal = totalAmount! + gstValue! + double.parse(amount);
    notifyListeners();
  }


}