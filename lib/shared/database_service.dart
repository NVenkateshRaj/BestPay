import 'package:bestpay/model/banklist.dart';
import 'package:bestpay/model/creditcard.dart';
import 'package:bestpay/model/customer.dart';
import 'package:bestpay/model/kyclist.dart';
import 'package:bestpay/model/payment.dart';
import 'package:bestpay/model/purpose.dart';
import 'package:bestpay/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../locator.dart';

class DatabaseService{

  final CollectionReference userList = FirebaseFirestore.instance.collection('Users');
  final CollectionReference customerList = FirebaseFirestore.instance.collection('Customers');
  final CollectionReference paymentList = FirebaseFirestore.instance.collection('Payments');
  final CollectionReference card = FirebaseFirestore.instance.collection('Card');
  final CollectionReference kycList = FirebaseFirestore.instance.collection('KYC');
  final CollectionReference purposeList = FirebaseFirestore.instance.collection('Purpose');
  final CollectionReference bankList = FirebaseFirestore.instance.collection('Bank');



  Future<void> createUserData(UserDetails userDetails) async {
    return await userList.doc(userDetails.userId).set(userDetails.toJson());
  }

  Future updateUserList(UserDetails userDetails) async {
    print("Update User Details");
    return await userList.doc(userDetails.userId).update(userDetails.toJson());
  }


  Future getUsersList() async {
    List itemsList = [];

    try {
      await userList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> createCustomer(CustomerCollection customer) async {
    return await customerList.doc(preferenceService.getBearerToken()).collection("Customers").doc(customer.customerId).set(customer.toJson());
  }

  Future updateCustomer(CustomerCollection customer) async {
    return await customerList.doc(preferenceService.getBearerToken()).collection("Customers").doc(customer.customerId).update(customer.toJson());
  }

  Future<void> deleteCustomer(String customerId) async{
    return await customerList.doc(preferenceService.getBearerToken()).collection("Customers").doc(customerId).delete();
  }

  Future<void> createPayment(PaymentCollection paymentCollection) async {
    return await paymentList.doc(preferenceService.getBearerToken()).collection("Payments").doc(paymentCollection.paymentId).set(paymentCollection.toJson());
   // return await paymentList.doc(paymentCollection.paymentId).set(paymentCollection.toJson());
  }

  Future<void> creditCardSave(CreditCard creditCard) async {
   // return await card.doc(creditCard.cardId).set(creditCard.toJson());
    return await card.doc(preferenceService.getBearerToken()).collection("Cards").doc(creditCard.cardId).set(creditCard.toJson());
  }

  Future<void> deleteCard(String cardId) async{
    //return await card.doc(cardId).delete();
    return await card.doc(preferenceService.getBearerToken()).collection("Cards").doc(cardId).delete();
  }

  Future<void> createKYC(KYCDetails kycDetails) async {
    return await kycList.doc(preferenceService.getBearerToken()).collection("KYC").doc(kycDetails.aadharId).set(kycDetails.toJson());
  }

  Future updateKYC(KYCDetails kycDetails) async {
    print(kycDetails.aadharId);
    print("kyc details");
    return await kycList.doc(preferenceService.getBearerToken()).collection("KYC").doc(kycDetails.aadharId).update(kycDetails.toJson());
  }

  // Future updatePaymentData(PaymentCollection paymentCollection) async {
  //   return await paymentList.doc(paymentCollection.paymentId).update(paymentCollection as Map<String,dynamic>);
  // }



  Future getUserList(String phoneNumber,{String? password}) async {
    DocumentSnapshot? data;
    try {
      await userList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          if(password!=null){
            if(element['phoneNumber'] == phoneNumber && element['password'] == password){
              data = element;
            }
          }
          else{
            if(element['phoneNumber'] == phoneNumber){
              data = element;
            }
          }
        });
      });
      print("data is ${data.toString()}");
      return data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getUserData(String phoneNumber) async {
    UserDetails? userDetails;
    try {
      await userList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          if(element['phoneNumber'] == phoneNumber){
            userDetails = UserDetails(
              name: element['name'],
              phoneNumber: element['phoneNumber'],
              password: element['password'],
              email: element['email'],
              userId: element['userId']
            );
          }
        });
      });
      return userDetails;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<List<CustomerCollection>> getCustomerList() async {
    List<CustomerCollection> customerCollection= [];
    try {
      await customerList.doc(preferenceService.getBearerToken()).collection("Customers").get().then((querySnapshot){
        querySnapshot.docs.forEach((element) {
            customerCollection.add(CustomerCollection.fromJson(Map<String, dynamic>.from(element.data())));
          });
      });
      return customerCollection;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<PaymentCollection>> getPaymentList() async {
    List<PaymentCollection> paymentCollection= [];
    try {
      await paymentList.doc(preferenceService.getBearerToken()).collection("Payments").get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          paymentCollection.add(PaymentCollection.fromJson(element.data()));
        });
      });
      return paymentCollection;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future getKYCList() async {
    KYCDetails? kycDetailsList;
    try {
      await kycList.doc(preferenceService.getBearerToken()).collection("KYC").get().then((querySnapshot){
        querySnapshot.docs.forEach((element) {
          kycDetailsList = KYCDetails(
              name: element['name'],
              aadharNumber: element['aadharNumber'],
              address: element['address'],
              aadharId: element['aadharId'],
              imageUrl: element['imageUrl'],
              aadharImage: element['aadharImage']
          );
        });
      });
      return kycDetailsList;
    } catch (e) {
      print(e.toString());
    }
  }


  Future<List<PurposeType>> getPurposeList() async {
    List<PurposeType> purposeCollection= [];
    try {
      await purposeList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          purposeCollection.add(PurposeType.fromJson(Map<String, dynamic>.from(element.data() as Map<String, dynamic>)));
        });
      });
      return purposeCollection;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<BankList>> getBankList() async {
    List<BankList> bankCollection= [];
    try {
      await bankList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          bankCollection.add(BankList.fromJson(Map<String, dynamic>.from(element.data() as Map<String, dynamic>)));
        });
      });
      return bankCollection;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<CreditCard>> getCardList() async {
    List<CreditCard> cardCollection= [];
    try {
      await card.doc(preferenceService.getBearerToken()).collection("Cards").get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          cardCollection.add(CreditCard.fromJson(element.data()));
        });
      });
      return cardCollection;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}