import 'package:bestpay/core/enum/viewstate.dart';
import 'package:bestpay/model/banklist.dart';
import 'package:bestpay/model/creditcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import '../../../locator.dart';
import '../../vgts_base_view_model.dart';

class CardPageViewModel extends VGTSBaseViewModel{
  var uuid = Uuid();
  NameFormFieldController userNameController = NameFormFieldController(ValueKey("txtCompanyname"),required: true,requiredText: "Enter Credit Card Holder Name");
  FormFieldController cardController = FormFieldController(ValueKey("txtgst"),required: true,textCapitalization: TextCapitalization.characters,maxLength: 16,inputFormatter: [ FilteringTextInputFormatter.allow(RegExp("[0-9]")),],textInputType: TextInputType.number);
  DropdownFieldController<BankList> bankController = DropdownFieldController<BankList>(ValueKey("dBankList"), keyId: "id", valueId: "bank",required: true);
  List<BankList> bankList = [];
  List<CreditCard> cardList = [];
  late CreditCard creditCard;
  final GlobalKey<FormState> userInfoFormKey = GlobalKey<FormState>();

  inIt(){
    setState(ViewState.Busy);
    getCardList();
    getBankList();
    setState(ViewState.Idle);
    notifyListeners();
  }

  getBankList()async{
    bankList = await dataBaseService.getBankList();
    print(bankList.length);
    bankController.list = bankList;
    notifyListeners();
  }

  getCardList()async{
    cardList = await dataBaseService.getCardList();
    notifyListeners();
  }

  deleteCard(String cardId)async{
    try{
      await dataBaseService.deleteCard(cardId);
      inIt();
    }catch(e){}

    notifyListeners();
  }

  saveCard()async{
    setState(ViewState.Busy);
    creditCard = CreditCard(
      name: userNameController.text,
      cardNumber: cardController.text,
      bankName: bankController.value!.bankName,
      cardId: uuid.v4(),
      cardType: "Visa"
    );
    try{
      await dataBaseService.creditCardSave(creditCard);
       navigationService.pop();
    }catch(e){
      print(e);
    }
    setState(ViewState.Idle);
    notifyListeners();
  }
}